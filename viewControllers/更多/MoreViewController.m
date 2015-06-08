//
//  MoreViewController.m
//  测试使用侧边栏
//
//  Created by student on 15/6/6.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import "MoreViewController.h"
#import <RETableViewManager.h>
#import "SDImageCache.h"
#import "MBProgressHUD+MJ.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "AboutMeController.h"
@interface MoreViewController () <MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) RETableViewManager *mgr;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建tableView管理者
    [self addTableViewManager];
    [self systemSection];
    [self addSuggestSection];
    [self addAboutSection];
}

// 创建tableView管理者
- (void)addTableViewManager {
    self.mgr = [[RETableViewManager alloc] initWithTableView:self.tableView];
    self.mgr.style.defaultCellSelectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)systemSection {
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"系统设置"];
    RETableViewItem *cleanCache = [RETableViewItem itemWithTitle:@"清除缓存" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
        // 显示清除缓存
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"清除缓存中...";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            // 清除缓存
            NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            
            NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
            NSUInteger fileCount = [files count];
            //NSLog(@"files :%ld",[files count]);
            for (NSString *p in files) {
                NSError *error;
                NSString *path = [cachPath stringByAppendingPathComponent:p];
                if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                }
            }
            
            hud.mode = MBProgressHUDModeText;
            hud.labelText = [NSString stringWithFormat:@"清除缓存文件%ld个!",fileCount];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                // Do something...
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            
        });
        
        
    }];
    [section addItem:cleanCache];
    [self.mgr addSection:section];
}

// 添加反馈建议的section
- (void)addSuggestSection {
    RETableViewSection *section = [RETableViewSection section];
    section.headerTitle = @"反馈建议";
    RETableViewItem *scoreItem = [RETableViewItem itemWithTitle:@"评价打分" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        
    }];
    RETableViewItem *issueItem = [RETableViewItem itemWithTitle:@"问题与建议" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [self sendMailInApp];
    }];
    [section addItemsFromArray:@[scoreItem, issueItem]];
    [self.mgr addSection:section];
}

// 发送邮件
- (void)sendMailInApp {
    // 获取Mail类
    Class mailClass = NSClassFromString(@"MFMailComposeViewController");
    // 如果mail不为空
    if (Nil != mailClass) {
        // 如果类可以用
        if ([mailClass canSendMail]) {
            [self displayComposerSheet];
        }
    }
}

- (void)displayComposerSheet {
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    
    mailPicker.mailComposeDelegate = self;
    
    [mailPicker setSubject:@"健康快递iOS反馈"];
    
    NSArray *toRecipients = @[@"673229963@qq.com", @"10393625@qq.com"];
    [mailPicker setToRecipients:toRecipients];
    NSString *emailBody = @"来自我的iPhone\n";
    [mailPicker setMessageBody:emailBody isHTML:NO];
    [self presentViewController:mailPicker animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *msg;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            break;
        case MFMailComposeResultSaved:
            msg = @"邮件保存成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultSent:
            msg = @"邮件发送成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultFailed:
            msg = @"邮件发送失败";
            [self alertWithTitle:nil msg:msg];
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) alertWithTitle: (NSString *)_title_ msg: (NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

// 添加关于我们section
- (void)addAboutSection {
    RETableViewSection *section = [RETableViewSection section];
    section.headerTitle = @"关于我们";
    __weak typeof (self) weakSelf = self;
    RETableViewItem *item = [RETableViewItem itemWithTitle:@"关于" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        AboutMeController *aboutVC = [[AboutMeController alloc] init];
        [weakSelf.navigationController pushViewController:aboutVC animated:YES];
//        [self.navigationController pushViewController:[AboutMeViewController new] animated:YES];
    }];
    [section addItem:item];
    [self.mgr addSection:section];
}

// 重写初始化方法
- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

@end
