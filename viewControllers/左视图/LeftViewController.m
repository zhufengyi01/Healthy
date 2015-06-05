//
//  LeftViewController.m
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/3.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import "LeftViewController.h"
#import "SecondViewController.h"
#import "KnoleViewController.h"
#import "FoodViewController.h"
#import "NewViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UIViewController+MMDrawerController.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *myTableView;

@property(nonatomic,strong) NSMutableArray  *dataArray;

@end

@implementation LeftViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.tabBarController.tabBar.hidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor redColor];
    self.dataArray=[NSMutableArray arrayWithObjects:@"首页",@"选项1",@"选项2",@"选项3", nil];
    self.myTableView =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myTableView.dataSource=self;
    self.myTableView.delegate=self;
    [self.view addSubview:self.myTableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *CellID=@"cell";
    UITableViewCell  *cell =[tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.textLabel.text=[self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        UINavigationController *na =[[UINavigationController alloc]initWithRootViewController:[NewViewController new]];
    [self.mm_drawerController setCenterViewController:na withFullCloseAnimation:YES completion:nil];
    }
    
   else  if (indexPath.row==1) {
        UINavigationController  *na =[[UINavigationController alloc]initWithRootViewController:[SecondViewController new]];
    [self.mm_drawerController setCenterViewController:na withFullCloseAnimation:YES completion:nil];
    }
   else if (indexPath.row==2) {
        UINavigationController  *na =[[UINavigationController alloc]initWithRootViewController:[KnoleViewController new]];
        [self.mm_drawerController setCenterViewController:na withFullCloseAnimation:YES completion:nil];
    }
   else if (indexPath.row==3) {
       UINavigationController  *na =[[UINavigationController alloc]initWithRootViewController:[FoodViewController new]];
       [self.mm_drawerController setCenterViewController:na withFullCloseAnimation:YES completion:nil];
   }
    


    
    
    
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
