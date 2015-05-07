//
//  CustmoTabBarController.m
//  CustomTabBar
//
//  Created by qianfeng on 14-8-30.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "CustmoTabBarController.h"
//#import "NewViewController.h"
#import "CustomTabBar.h"
#import "ZCControl.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
#import "NewViewController.h"
#import "KnoleViewController.h"
#import "FoodViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
//#import "UIImage+ImageWithColor.h"
@interface CustmoTabBarController ()<CustomTabBarDelegate>
@property (nonatomic, strong) CustomTabBar * m_tabBar;
@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation CustmoTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createControllers];
    [self createCustomTabBar];
}

- (void)createControllers
{
    
    UINavigationController  *na1 =[[UINavigationController alloc]initWithRootViewController:[LeftViewController new] ];
    
    UINavigationController  *na2 =[[UINavigationController alloc]initWithRootViewController:[NewViewController new]];
    
    self.drawerController =[[MMDrawerController alloc]initWithCenterViewController:na2 leftDrawerViewController:na1];
    
    
    [self.drawerController setShowsShadow:YES];
    self.drawerController.shadowRadius=4;
    self.drawerController.centerHiddenInteractionMode=MMDrawerOpenCenterInteractionModeFull;
    self.drawerController.shadowOpacity=0.6;
    self.drawerController.shadowColor=[UIColor blackColor];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    //[self.drawerController  setMaximumLeftDrawerWidth:200];
    [self.drawerController setMaximumRightDrawerWidth:240.0];
    //全手势开启左边试图
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    //全手势关闭左边试图
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //设置开启动画模式
    [[MMExampleDrawerVisualStateManager  sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    
    
    KnoleViewController * movieVC = [[KnoleViewController alloc] init];
    UINavigationController * secondNav = [[UINavigationController alloc] initWithRootViewController:movieVC];
    
    FoodViewController * notVC = [[FoodViewController alloc] init];
    UINavigationController * thirdNav = [[UINavigationController alloc] initWithRootViewController:notVC];
    
  
    NSArray * controllerArr = [NSArray arrayWithObjects:self.drawerController, secondNav, thirdNav, nil];
    self.viewControllers = controllerArr;
    
}

-(void)createCustomTabBar
{
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.m_tabBar = [[CustomTabBar alloc] initWithFrame:CGRectMake(0, 1, frame.size.width, 48)];
    self.m_tabBar.m_delegate = self;
    self.m_tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_backgroud_color.png"]]; // 设置tabar 的背景图片
    [self.tabBar addSubview:self.m_tabBar];
    
    
}
#pragma  mark ---
#pragma  mark ---   ---CustomTabBarDelegate  ----
#pragma  mark ---
- (void)buttonPresedInCustomTabBar:(NSUInteger)index
{
    self.selectedIndex = index;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
