//
//  KnoleViewController.m
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/4.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import "KnoleViewController.h"
#import "ZCControl.h"
#import "Const.h"
#import "NetApi.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "newModel.h"
#import "NewTableViewCell.h"
#import "NeDetailViewController.h"
@interface KnoleViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int page;
    int pagesize;

}
@property(nonatomic,strong) UITableView  *tableView;
@property(nonatomic,strong)NSMutableArray  *dataArray;
@end

@implementation KnoleViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.toolbarHidden=YES;

////    self.navigationController.navigationBar.tintColor=VBlue_color;
//    self.tabBarController.tabBar.hidden=NO;
//    self.navigationController.navigationBar.hidden=NO;
//     //细节1:混合色
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
    self.view.backgroundColor =[UIColor yellowColor];
    [self createNavigation];
    [self initData];
    [self createTableView];
    [self requestList];
    
}
-(void)createNavigation
{
    
        UILabel  *titleLable=[ZCControl createLabelWithFrame:CGRectMake(0, 0, 100, 20) Font:16 Text:@"健康常识"];
        titleLable.textColor=[UIColor whiteColor];
        titleLable.font=[UIFont boldSystemFontOfSize:18];
        titleLable.textAlignment=NSTextAlignmentCenter;
        self.navigationItem.titleView=titleLable;

}

-(void)initData{
    page=1;
    pagesize=20;
    self.dataArray = [[NSMutableArray alloc]init];
}
-(void)createTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kDeviceWidth, kDeviceHeight-0)];
    self.tableView.delegate=self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource=self;
    //self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self setupRefreshHeader ];
    [self setupRefreshFooter];
    
}
#pragma mark UITableView + 下拉刷新 动画图片
- (void)setupRefreshHeader
{
    // 添加动画图片的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self.tableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 隐藏时间
    self.tableView.header.updatedTimeHidden = YES;
    
    // 隐藏状态
    self.tableView.header.stateHidden = YES;
    
    
    [self.tableView.header setTitle:@"Pull down to refresh" forState:MJRefreshHeaderStateIdle];
    [self.tableView.header setTitle:@"Release to refresh" forState:MJRefreshHeaderStatePulling];
    [self.tableView.header setTitle:@"Loading ..." forState:MJRefreshHeaderStateRefreshing];
    
    // 马上进入刷新状态
    [self.tableView.gifHeader beginRefreshing];
    
    // 此时self.tableView.header == self.tableView.gifHeader
}

- (void)setupRefreshFooter
{
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置文字
    [self.tableView.footer setTitle:@"上拉刷新" forState:MJRefreshFooterStateIdle];
    [self.tableView.footer setTitle:@"加载更多 ..." forState:MJRefreshFooterStateRefreshing];
    [self.tableView.footer setTitle:@"No more data" forState:MJRefreshFooterStateNoMoreData];
    
    //   // 设置字体
    self.tableView.footer.font = [UIFont systemFontOfSize:12];
    
    // 设置颜色
    self.tableView.footer.textColor = VLight_GrayColor;
    
    // 此时self.tableView.footer == self.tableView.legendFooter
}
//添加新数据
- (void)loadNewData
{
    // 1.添加假数据
    //   for (int i = 0; i<5; i++) {
    //      [self.dataArray insertObject:MJRandomData atIndex:0];
    //   }
         if (self.dataArray.count>0) {
            [self.dataArray removeAllObjects];
        }
        page=1;
    [self requestList];
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.header endRefreshing];
    });
}
#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    // 1.添加假数据
    //   for (int i = 0; i<5; i++) {
    //      [self.d addObject:MJRandomData];
    //   }
    page++;
    [self requestList];
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.tableView.footer endRefreshing];
    });
}
-(void)requestList
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString;
         //全部
        urlString =[NSString stringWithFormat:@"%@?limit=%d&page=%d",ApiKnoleList,pagesize,page];
        
     [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if ([[responseObject objectForKey:@"success"] boolValue]==YES) {
            if ([responseObject objectForKey:@"yi18"])
            {
                NSMutableArray  *array =   [responseObject objectForKey:@"yi18"];
                     for (NSDictionary  *dict in array) {
                        newModel *model =[[newModel alloc]init];
                        if (model) {
                            [model setValuesForKeysWithDictionary:dict];
                            if (self.dataArray==nil) {
                                self.dataArray=[[NSMutableArray alloc]init];
                            }
                            [self.dataArray addObject:model];
                        }
                    }
                }
            
            
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
         return self.dataArray.count;
   
 }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       newModel  *model;
         if (self.dataArray.count>indexPath.row) {
            model =[self.dataArray objectAtIndex:indexPath.row];
        }
    
     NSString  *imageString =model.img;
    if (imageString.length==0||!imageString) {
        return 80;
    }
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString  *cellID=@"cell1";
        NewTableViewCell  *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell =[[NewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        if (self.dataArray.count>indexPath.row) {
            cell.model =[self.dataArray objectAtIndex:indexPath.row];
            cell.pageType=NSPageTypeKnoleController;
        }
        // cell.textLabel.text=@"资讯";
        [cell setCellValueforRowIndex:indexPath.row];
        return cell;
    
 }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NeDetailViewController *newVc=[[NeDetailViewController alloc]init];
    newModel  *model;
    newVc.pageType=NSDetailPageTypeKnoleController;
    model =[self.dataArray objectAtIndex:indexPath.row];
    newVc.detailId=model.Id;
    newVc.detailName=model.title;
    [self.navigationController pushViewController:newVc animated:YES];
    
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
