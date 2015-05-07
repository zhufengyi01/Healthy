//
//  FoodViewController.m
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/4.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import "FoodViewController.h"
#import "ZCControl.h"
#import "Const.h"
#import "NetApi.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "newModel.h"

@interface FoodViewController ()
{
    UIView  *foodView;
}

@property(nonatomic,strong)NSMutableArray  *FoodcateArray; //食谱列表

@property(nonatomic,strong)NSMutableArray  *dataArray;

@property(nonatomic,strong)UIScrollView    *scrollView;

@end

@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor purpleColor];
    [self createNavigation];
    [self initData];
    [self  createScrollerView];
    [self requestList];
    
}
-(void)createNavigation
{
    
    UILabel  *titleLable=[ZCControl createLabelWithFrame:CGRectMake(0, 0, 100, 20) Font:16 Text:@"健康常识"];
    titleLable.textColor=VBlue_color;
    titleLable.font=[UIFont boldSystemFontOfSize:16];
    titleLable.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleLable;
    
}

-(void)initData{
     self.FoodcateArray= [[NSMutableArray alloc]init];
}

-(void)requestList
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString;
    //全部
    urlString =[NSString stringWithFormat:@"%@",ApiFoodcategory];
    [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"success"] boolValue]==YES) {
            if ([responseObject objectForKey:@"yi18"])
            {
                self.FoodcateArray = [responseObject objectForKey:@"yi18"];
                [self createFoodView];
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
-(void)createScrollerView
{
    self.scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, kDeviceWidth, kDeviceHeight)];
    self.scrollView.contentSize=CGSizeMake(kDeviceWidth, 2*kDeviceHeight);
    //self.scrollView.backgroundColor =[UIColor redColor];
    self.scrollView.backgroundColor=View_BackGround;
    [self.view addSubview:self.scrollView];

}
-(void)createFoodView
{
    foodView =[[UIView alloc]initWithFrame:CGRectMake(0,10, kDeviceWidth, 200)];
    foodView.backgroundColor =[UIColor whiteColor];
    foodView.layer.shadowColor=[UIColor grayColor].CGColor;
    foodView.layer.shadowOpacity=0.7;
    foodView.layer.shadowOffset=CGSizeMake(kDeviceWidth, 20);
    foodView.layer.shadowRadius=4;
    [self.scrollView addSubview:foodView];

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
