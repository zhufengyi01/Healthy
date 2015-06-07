//
//  MainTabBarController.m
//  测试使用侧边栏
//
//  Created by student on 15/6/6.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import "MainTabBarController.h"
#import "NewViewController.h"
#import "MainNavViewController.h"
#import "KnoleViewController.h"
#import "FoodViewController.h"
#import "MoreViewController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.m_arrNormal = [NSArray arrayWithObjects:@"feed_tab_butten_normal.png", @"movie_tab_butten_normal.png", @"notice_tab_butten_normal.png", nil];
//    self.m_arrSelected = [NSArray arrayWithObjects:@"feed_tab_butten_press.png", @"movie_tab_butten_press.png", @"notice_tab_butten_press.png", nil];
//    titleArray=@[@"资讯",@"常时",@"药品"];

    NewViewController *newVC = [[NewViewController alloc] init];
    // 添加资讯控制器
    [self addChildVc:newVC title:@"资讯" image:@"feed_tab_butten_normal.png" selectedImage:@"feed_tab_butten_press.png"];
    
    KnoleViewController *knoleVC = [[KnoleViewController alloc] init];
    [self addChildVc:knoleVC title:@"常识" image:@"movie_tab_butten_normal.png" selectedImage:@"movie_tab_butten_press.png"];
    
    // 添加药品控制器
    FoodViewController *foodVC = [[FoodViewController alloc] init];
    [self addChildVc:foodVC title:@"药品" image:@"notice_tab_butten_normal.png" selectedImage:@"notice_tab_butten_press.png"];
    
    // 添加更多控制器
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    [self addChildVc:moreVC title:@"更多" image:@"navigationbar_more" selectedImage:@"navigationbar_more_highlighted"];
    
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    MainNavViewController *nav = [[MainNavViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
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
