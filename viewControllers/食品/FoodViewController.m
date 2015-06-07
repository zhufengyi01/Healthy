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
#import "FootListViewController.h"
@interface FoodViewController ()
{
    UIView  *foodView;
}

@property(nonatomic,strong)NSMutableArray  *FoodcateArray; //食谱列表

@property(nonatomic,strong)NSMutableArray  *dataArray;

@property(nonatomic,strong)UIScrollView    *scrollView;

@end

@implementation FoodViewController
-(void)viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:YES];
//    self.tabBarController.tabBar.hidden=NO;
//    self.navigationController.navigationBar.hidden=NO;
//    //细节1:混合色
//    //细节2: 只有设置为透明后才会出现
//    self.navigationController.navigationBar.backgroundColor=VBlue_color;
//    //细节: 设置透明后视图会上移
//    [self.navigationController.navigationBar setTranslucent:YES];
//    [self.navigationController.navigationBar setBarTintColor:VBlue_color];
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    


}
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
    
    UILabel  *titleLable=[ZCControl createLabelWithFrame:CGRectMake(0, 0, 100, 20) Font:16 Text:@"健康食谱"];
    titleLable.textColor=[UIColor whiteColor];
    titleLable.font=[UIFont boldSystemFontOfSize:18];
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
    self.scrollView.contentSize=CGSizeMake(kDeviceWidth, kDeviceHeight);
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
    //
    UILabel  *lable =[ZCControl createLabelWithFrame:CGRectMake(20, 10, 100, 25) Font:16 Text:@"食谱分类"];
    lable.textColor=VGray_color;
    lable.font =[UIFont boldSystemFontOfSize:16];
    [foodView addSubview:lable];
    //创建按钮
    for ( int i=0; i<self.FoodcateArray.count; i++) {
        float  x=(i%4)*((kDeviceWidth-20)/4)+10;
        float  y=(i/4)*35+45;
        float  width=(kDeviceWidth-20)/4;
        float  height=35;
        NSString  *title=[[self.FoodcateArray objectAtIndex:i] objectForKey:@"name"];
        NSInteger  tag =[[[self.FoodcateArray objectAtIndex:i] objectForKey:@"id"] integerValue];
        UIButton  *btn =[ZCControl createButtonWithFrame:CGRectMake(x, y, width, height) ImageName:nil Target:self Action:@selector(FoodListClick:) Title:@""];
        btn.tag=tag+1000;
        btn.titleLabel.font =[UIFont systemFontOfSize:14];
        [btn setTitleColor:VBlue_color forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        [foodView addSubview:btn];
    }
}
//食谱分类
-(void)FoodListClick:(UIButton *) btn
{
    FootListViewController  *list =[[FootListViewController alloc]init];
    list.category_id=[NSString stringWithFormat:@"%ld",btn.tag-1000];
    for (newModel *model in self.dataArray) {
        if ([model.Id isEqualToString:list.category_id]) {
            list.category_name=model.name;
            break;
        }
    }
    [self.navigationController pushViewController:list animated:YES];
    
    

    
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
