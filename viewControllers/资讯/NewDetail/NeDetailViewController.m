//
//  NeDetailViewController.m
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/5.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import "NeDetailViewController.h"
#import "ZCControl.h"
#import "Const.h"
#import "NetApi.h"
#import "newModel.h"
#import "AFNetworking.h"
#import "M80AttributedLabel.h"
#import "Helper.h"
#import "MMProgressHUD.h"
@interface NeDetailViewController ()

{

}
@property(strong,nonatomic)UILabel  *titleLable;

@property(nonatomic,strong)UILabel  *timeLable;

@property(nonatomic,strong)UILabel  *autorLable;


@property(strong,nonatomic)M80AttributedLabel  *contentLable;


@property(strong,nonatomic)UIScrollView   *scrollView;


@property(strong,nonatomic)newModel  *model;
@end

@implementation NeDetailViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.backgroundColor=VBlue_color;
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBarTintColor:VBlue_color];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    self.tabBarController.tabBar.hidden=YES;
   // self.navigationController.toolbarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =View_BackGround;
    [self createNavagtion];
    
    [self requestNewDetail];
    //[self creatUI];
}
-(void)createNavagtion
{
    UILabel  *titleLable=[ZCControl createLabelWithFrame:CGRectMake(0, 0, 100, 20) Font:16 Text:self.detailName];
    titleLable.textColor=VBlue_color;
    titleLable.font=[UIFont boldSystemFontOfSize:16];
    titleLable.textAlignment=NSTextAlignmentCenter;
  //  self.navigationItem.titleView=titleLable;
}

-(void)creatUI
{

    self.scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0,64, kDeviceWidth, kDeviceHeight)];
    self.scrollView.contentSize=CGSizeMake(kDeviceWidth, 2*kDeviceHeight);
    //self.scrollView.backgroundColor =[UIColor redColor];
    self.scrollView.backgroundColor=View_BackGround;
    [self.view addSubview:self.scrollView];
    
    NSString  *titleString =self.model.title;
    CGSize   Tsize =[titleString boundingRectWithSize:CGSizeMake(kDeviceWidth-20, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary  dictionaryWithObject:[UIFont systemFontOfSize:14]  forKey:NSFontAttributeName] context:nil].size;    //名
    
    self.titleLable =[ZCControl createLabelWithFrame:CGRectMake(10, 10, kDeviceWidth-20, 30) Font:14 Text:self.model.title];
    self.titleLable.textColor=[UIColor blackColor];
    self.timeLable.textAlignment=NSTextAlignmentCenter;
    self.titleLable.font=[UIFont boldSystemFontOfSize:14];
    self.titleLable.frame=CGRectMake(10, 10, kDeviceWidth-20, Tsize.height+5);
    [self.scrollView addSubview:self.titleLable];
    
//    self.cou =[ZCControl createLabelWithFrame:CGRectMake(10, 10, kDeviceWidth-20, 30) Font:14 Text:self.model.title];
//    self.titleLable.textColor=[UIColor blackColor];
//    self.timeLable.textAlignment=NSTextAlignmentCenter;
//    self.titleLable.font=[UIFont boldSystemFontOfSize:14];
//    self.titleLable.frame=CGRectMake(10, 10, kDeviceWidth-20, Tsize.height+5);
//    [self.scrollView addSubview:self.titleLable];

    //s
    NSString  *timeString =[NSString stringWithFormat:@"共浏览:%@     时间:%@",self.model.count,self.model.time];
    self.timeLable =[ZCControl createLabelWithFrame:CGRectMake(10, self.titleLable.frame.origin.y+self.titleLable.frame.size.height+10, kDeviceWidth-20, 15) Font:14 Text:timeString];
    self.timeLable.textColor=VGray_color;
    self.timeLable.textAlignment=NSTextAlignmentCenter;
    self.timeLable.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.timeLable];
    
    //作者
    
    self.autorLable =[ZCControl createLabelWithFrame:CGRectMake(10, self.timeLable.frame.origin.y+self.timeLable.frame.size.height+0, kDeviceWidth-20, 15) Font:14 Text:[NSString stringWithFormat:@"作者:%@",self.model.author]];
    self.autorLable.textColor=VGray_color;
    self.autorLable.textAlignment=NSTextAlignmentCenter;
    self.autorLable.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.autorLable];

    
    
    ///内容
    self.contentLable =[[M80AttributedLabel alloc]initWithFrame:CGRectMake(10,self.autorLable.frame.origin.y+self.autorLable.frame.size.height+10,kDeviceWidth-20,100)];
    self.contentLable.font=[UIFont systemFontOfSize:14];
    if (IsIphone6plus) {
        self.contentLable.font =[UIFont systemFontOfSize:16];
    }
    self.contentLable.textColor=VGray_color;
    self.contentLable.backgroundColor=[UIColor clearColor];
    self.contentLable.lineSpacing=0;
    [self.scrollView addSubview:self.contentLable];
    
    NSString  *ContentString = [Helper  filterHTML: self.model.message];
    [self.contentLable appendText:[Helper filterHTML:self.model.message]];
    self.titleLable.textAlignment=NSTextAlignmentCenter;

    CGSize   Csize =[ContentString boundingRectWithSize:CGSizeMake(kDeviceWidth-30, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary  dictionaryWithObject:self.contentLable.font  forKey:NSFontAttributeName] context:nil].size;
    self.contentLable.frame=CGRectMake(15, self.timeLable.frame.origin.y+self.timeLable.frame.size.height+0, kDeviceWidth-30, Csize.height+10);
    
    self.scrollView.contentSize=CGSizeMake(0, self.contentLable.frame.origin.y+self.contentLable.frame.size.height+100);
    
}
-(void)requestNewDetail
{
   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString;
    if (self.pageType==NSDetailPageTypeNewListController) {
          urlString =[NSString stringWithFormat:@"%@?id=%@",ApiNewDetail,self.detailId];
    }
   else if(self.pageType==NSDetailPageTypeKnoleController)
   {
       
       urlString =[NSString stringWithFormat:@"%@?id=%@",ApiKnoleDetail,self.detailId];

   }
    
   [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
      if ([[responseObject objectForKey:@"success"] boolValue]==YES) {
          self.model =[[newModel alloc]init];
          if (self.model) {
              [self.model setValuesForKeysWithDictionary:[responseObject objectForKey:@"yi18"]];
          }
          [self creatUI];

      }
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
   NSLog(@"Error: %@", error);
}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
