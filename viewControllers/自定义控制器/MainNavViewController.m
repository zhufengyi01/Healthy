//
//  MainNavViewController.m
//  测试使用侧边栏
//
//  Created by student on 15/6/6.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import "MainNavViewController.h"
#import "Const.h"
@interface MainNavViewController ()

@end

@implementation MainNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundColor:VBlue_color];
    //[navBar setTranslucent:YES];
    [navBar setBarTintColor:VBlue_color];
    [navBar setTintColor:VBlue_color];
    //[navBar setBarStyle:UIBarStyleBlack];
    navBar.tintColor = [UIColor whiteColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
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
