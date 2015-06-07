//
//  FootListViewController.m
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/8.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import "FootListViewController.h"
#import "ZCControl.h"
#import "Const.h"
#import "FoodListTableViewCell.h"
#import "AFNetworking.h"
#import  "MJRefresh.h"
#import "NetApi.h"
#import "newModel.h"
#import "FoodDetailViewController.h"
@interface FootListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int page;
    int pagesize;

}
@property(nonatomic,strong) UITableView  *tableView;
@property(nonatomic,strong)NSMutableArray  *dataArray;

@end

@implementation FootListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNavagtion];
    [self initData];
    [self createTableView];

}

-(void)createNavagtion
{
        UILabel  *titleLable=[ZCControl createLabelWithFrame:CGRectMake(0, 0, 100, 20) Font:16 Text:[NSString stringWithFormat:@"健康食谱"]];
        titleLable.textColor=[UIColor whiteColor];
        titleLable.font=[UIFont boldSystemFontOfSize:18];
        titleLable.textAlignment=NSTextAlignmentCenter;
        self.navigationItem.titleView=titleLable;
}
-(void)initData{
    self.dataArray = [[NSMutableArray alloc]init];
     page=1;
    pagesize=20;
    
}
-(void)createTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kDeviceWidth, kDeviceHeight-0)];
    self.tableView.delegate=self;
    self.tableView.backgroundColor = View_BackGround;
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
        urlString =[NSString stringWithFormat:@"%@?id=%@&limit=%d&page=%d",ApiFoodList,self.category_id,pagesize,page];
    
    [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"success"] boolValue]==YES) {
            if ([responseObject objectForKey:@"yi18"])
            {
                NSMutableArray  *array =   [responseObject objectForKey:@"yi18"];
                NSLog(@"array====%@",array);
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
        return 90;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString  *cellID=@"cell1";
        FoodListTableViewCell  *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell =[[FoodListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        if (self.dataArray.count>indexPath.row) {
            cell.model =[self.dataArray objectAtIndex:indexPath.row];
            [cell setCellValueForRowIndex:indexPath.row];

        }
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FoodDetailViewController  *de= [[FoodDetailViewController alloc]init];
  newModel  *model=  [self.dataArray objectAtIndex:indexPath.row];
    de.food_id=model.Id;
    de.food_name=model.name;
    [self.navigationController pushViewController:de animated:YES];
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
