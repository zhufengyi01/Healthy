//
//  NewViewController.m
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/4.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import "NewViewController.h"
#import "ZCControl.h"
#import "Const.h"
#import "NetApi.h"
#import "AFNetworking.h"
#import "newModel.h"
#import "ADCircularMenuViewController.h"
#import "NewTableViewCell.h"
#import "NeDetailViewController.h"
#import "MJRefresh.h"
@interface NewViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,ADCircularMenuDelegate>
{
    int page;
    int pagesize;
   int Id;
   UISegmentedControl *segment;
   UISearchBar  *search;
   ADCircularMenuViewController *circularMenuVC;
   UIImageView  *seachView;
   UIButton *Searchbutton;
   UIButton  *Menubtn;

   
}
@property(nonatomic,strong) UITableView  *tableView;
@property(nonatomic,strong)NSMutableArray  *dataArray;
@property(nonatomic,strong) NSMutableArray  *hotArray;
@property(nonatomic,strong)NSMutableArray  *categoryArray;
@property(nonatomic,strong)NSMutableArray  *searchArray ;

@end

@implementation NewViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=NO;
    self.navigationController.navigationBar.tintColor=VBlue_color;
    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor redColor];
   [self.navigationController.navigationBar  setBackgroundColor:[UIColor whiteColor]];

   [self createNavagtion];
   [self initData];
   [self createTableView];
   [self  createSeachView];
   //[self createMenu];
   

   //请求分类
    // [self requestCategoryList];
   //请求列表
   //  [self requestList];
   
}

-(void)createNavagtion
{
//    UILabel  *titleLable=[ZCControl createLabelWithFrame:CGRectMake(0, 0, 100, 20) Font:16 Text:@"健康速递"];
//    titleLable.textColor=VBlue_color;
//    titleLable.font=[UIFont boldSystemFontOfSize:16];
//    titleLable.textAlignment=NSTextAlignmentCenter;
//    self.navigationItem.titleView=titleLable;
   
   NSArray *segmentedArray = [[NSArray alloc] initWithObjects:@"全部", @"热门", nil];
   segment = [[UISegmentedControl alloc] initWithItems:segmentedArray];
   segment.frame = CGRectMake(kDeviceWidth/4, 0, kDeviceWidth/2, 28);
   segment.selectedSegmentIndex = 0;
   segment.backgroundColor = [UIColor clearColor];
   segment.tintColor =VBlue_color;
   
   NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]
                                            };
   [segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
   NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]
                                              };
   [segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
   
   [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
   [self.navigationItem setTitleView:segment];

//    Searchbutton =[ZCControl createButtonWithFrame:CGRectMake(0, 0,40,30) ImageName:nil Target:self Action:@selector(dealSearchShow:) Title:@"搜索"];
//   [Searchbutton setTitleColor:VBlue_color forState:UIControlStateNormal];
//   [Searchbutton setTitleColor:VGray_color forState:UIControlStateSelected];
//   [Searchbutton setTitle:@"隐藏" forState:UIControlStateSelected];
//   
//   UIBarButtonItem  *item =[[UIBarButtonItem alloc]initWithCustomView:Searchbutton];
//   self.navigationItem.rightBarButtonItem=item;
}
-(void)segmentClick:(UISegmentedControl *)seg
{
   if(seg.selectedSegmentIndex==0)
   {
      if (self.dataArray.count==0) {
         [self requestList];
      }
      else {
      [self.tableView reloadData];
      }
      
   }
   else if(seg.selectedSegmentIndex==1)
   {
      if (self.hotArray.count==0) {
         [self requestList];
      }
      else
      {
      [self.tableView reloadData];
      }
   }
   
}
-(void)dealSearchShow:(UIButton *) btn
{
   if (btn.selected==NO) {
       btn.selected=YES;
       [UIView animateWithDuration:0.6 animations:^{
           CGRect  Sframe = seachView.frame;
          Sframe.origin.y=64;
          seachView.frame=Sframe;
      } completion:^(BOOL finished) {
      }];
   }
   else if(btn.selected==YES)
   {
      btn.selected=NO;
      [UIView animateWithDuration:0.6 animations:^{
         CGRect  Sframe = seachView.frame;
         Sframe.origin.y=0;
         seachView.frame=Sframe;
      } completion:^(BOOL finished) {
      }];
      
   }
   
}
-(void)createSeachView
{
   seachView =[[UIImageView alloc]initWithFrame:CGRectMake(0,0, kDeviceWidth,50)];
   seachView.backgroundColor =View_ToolBar;
   seachView.userInteractionEnabled=YES;
   seachView.layer.shadowColor=VGray_color.CGColor;
   seachView.layer.shadowRadius=8;
   seachView.layer.shadowOpacity=0.7;
  // seachView.layer.shadowOffset
   [self.view addSubview:seachView];
   search=[[UISearchBar alloc]initWithFrame:CGRectMake(20,10, kDeviceWidth-40, 28)];
   search.placeholder=@"搜索电影";
   search.delegate=self;
   search.searchBarStyle = UISearchBarStyleMinimal;
   search.backgroundColor=[UIColor clearColor];
   [seachView addSubview:search];

}

-(void)initData{
    self.dataArray = [[NSMutableArray alloc]init];
    self.hotArray = [[NSMutableArray alloc]init];
     //self.categoryArray=[[NSMutableArray alloc]init];
    self.searchArray=[[NSMutableArray alloc]init];
     page=1;
     pagesize=20;
     Id=1;
}
//-(void)createMenu
//{
//   
//   Menubtn =[ZCControl createButtonWithFrame:CGRectMake(0,kDeviceHeight-kHeigthTabBar-kHeightNavigation, 40, 40) ImageName:nil Target:self Action:@selector(dealmenuClick) Title:@""];
//   Menubtn.backgroundColor =[UIColor whiteColor];
//   Menubtn.layer.cornerRadius=20;
//   Menubtn.layer.borderColor=VBlue_color.CGColor;
//   Menubtn.layer.borderWidth=3;
//   Menubtn.clipsToBounds=YES;
//   [Menubtn  setImage:[UIImage imageNamed:@"up_picture_blue"] forState:UIControlStateNormal];
//   [self.view addSubview:Menubtn];
//  
//   
//   //在标签上添加一个手势
//   UIPanGestureRecognizer   *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handelPan:)];
//   [Menubtn addGestureRecognizer:pan];
//}
-(void)handelPan:(UIPanGestureRecognizer *) pan
{
   CGPoint  point =[pan locationInView:self.view];
   Menubtn.center=point;
   
   
}
-(void)circularMenuClickedButtonAtIndex:(int)buttonIndex
{
   NSLog(@"======%d",buttonIndex);
   
}

//
//-(void)dealmenuClick
//{
//   NSArray *arrImageName = [[NSArray alloc] initWithObjects:@"movie_tab_butten_press@2x.png",
//                            @"movie_tab_butten_press@2x.png",
//                            @"movie_tab_butten_press@2x.png",
//                            @"movie_tab_butten_press@2x.png",
//                            @"movie_tab_butten_press@2x.png",
//                            @"movie_tab_butten_press@2x.png",
//                            @"movie_tab_butten_press@2x.png", nil];
//   
//   circularMenuVC = [[ADCircularMenuViewController alloc] initWithMenuButtonImageNameArray:arrImageName andCornerButtonImageName:@"feed_tab_butten_press@2x.png"];
//   circularMenuVC.delegateCircularMenu = self;
//   [circularMenuVC show];
//
//}
//
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
   [self.tableView.footer setTitle:@"Click or drag up to refresh" forState:MJRefreshFooterStateIdle];
   [self.tableView.footer setTitle:@"Loading more ..." forState:MJRefreshFooterStateRefreshing];
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
   
   if (segment.selectedSegmentIndex==0) {
   if (self.dataArray.count>0) {
      [self.dataArray removeAllObjects];
   }
   }
   else if(segment.selectedSegmentIndex==1)
   {
      if (self.hotArray.count>0) {
         [self.hotArray removeAllObjects];
      }
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


#pragma mark ------------requestData
//-(void)requestCategoryList
//{
//   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//  NSString *urlString =[NSString stringWithFormat:@"%@",ApiNewClass];
//   [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//      if ([[responseObject objectForKey:@"success"] intValue]==1) {
//         _categoryArray =[responseObject objectForKey:@"yi18"];
//         NSLog(@"类别======%@",responseObject);
//         
//      }
//   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//   NSLog(@"Error: %@", error);
//}];
//}
-(void)requestSearch
{
   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   NSString  *searchText =[[search text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   NSDictionary  *parameters =@{@"keyword":searchText};
   NSString *urlString =[NSString stringWithFormat:@"%@/search",ApiNewClass];
   [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
      if ([[responseObject objectForKey:@"success"] intValue]==1) {
         _categoryArray =[responseObject objectForKey:@"yi18"];
         NSLog(@"搜索=====%@",responseObject);
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
         [self.tableView reloadData];
         
      }
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      NSLog(@"Error: %@", error);
   }];
}


-(void)requestList
{
   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   NSString *urlString;
   if (segment.selectedSegmentIndex==0) {
      //全部
      urlString =[NSString stringWithFormat:@"%@?limit=%d&page=%d",ApiNewList,pagesize,page];

   }
   else if (segment.selectedSegmentIndex==1)
   {
      urlString =[NSString stringWithFormat:@"%@?type=count&limit=%d&page=%d",ApiNewList,pagesize,page];

   }
   
   [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
      
      if ([[responseObject objectForKey:@"success"] boolValue]==YES) {
         if ([responseObject objectForKey:@"yi18"])
         {
         NSMutableArray  *array =   [responseObject objectForKey:@"yi18"];
            if (segment.selectedSegmentIndex==0)
            {
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
         else if (segment.selectedSegmentIndex==1)
           {
             for (NSDictionary  *dict in array) {
                newModel *model =[[newModel alloc]init];
                  if (model) {
                     [model setValuesForKeysWithDictionary:dict];
                     if (self.hotArray==nil) {
                        self.hotArray=[[NSMutableArray alloc]init];
                     }
                     [self.hotArray addObject:model];
                  }
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
   if (segment.selectedSegmentIndex==0) {
      return self.dataArray.count;
   }
   else if(segment.selectedSegmentIndex==1)
   {
   return self.hotArray.count;
   }
   return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   newModel  *model;
   if (segment.selectedSegmentIndex==0) {
      if (self.dataArray.count>indexPath.row) {
          model =[self.dataArray objectAtIndex:indexPath.row];
      }
   }
   else if(segment.selectedSegmentIndex==1)
   {
      if (self.hotArray.count >indexPath.row) {
      model =[self.hotArray objectAtIndex:indexPath.row];
      }
   }
   NSString  *imageString =model.img;
   if (imageString.length==0||!imageString) {
      return 60;
   }
   return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (segment.selectedSegmentIndex==0) {
   static NSString  *cellID=@"cell1";
    NewTableViewCell  *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell =[[NewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
   if (self.dataArray.count>indexPath.row) {
     cell.model =[self.dataArray objectAtIndex:indexPath.row];
      cell.pageType=NSPageTypeNewAllListController;
      
   }
    // cell.textLabel.text=@"资讯";
   [cell setCellValueforRowIndex:indexPath.row];
      return cell;
   }
   
   
   else if (segment.selectedSegmentIndex==1)
   {
      static NSString  *cellID=@"cell2";
      NewTableViewCell  *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
      if (!cell) {
         cell =[[NewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
      }
         if (self.hotArray.count>indexPath.row) {
            cell.model =[self.hotArray objectAtIndex:indexPath.row];
            cell.pageType=NSPageTypeNewListController;
         }
       // cell.textLabel.text=@"资讯";
      [cell setCellValueforRowIndex:indexPath.row];
      return cell;
   }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
   NeDetailViewController *newVc=[[NeDetailViewController alloc]init];
   newModel  *model;
   if (segment.selectedSegmentIndex==0) {
      model =[self.dataArray objectAtIndex:indexPath.row];
      
   }
   else if (segment.selectedSegmentIndex==1)
   {   model =[self.hotArray objectAtIndex:indexPath.row];
   }
   newVc.pageType=NSDetailPageTypeNewListController;
   newVc.detailId=model.Id;
   newVc.detailName=model.title;
   [self.navigationController pushViewController:newVc animated:YES];
   
}
#pragma mark   ----------------scrollViewDelegate-----------------------

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 
   [search resignFirstResponder];
   Searchbutton.selected=NO;
   [UIView animateWithDuration:0.6 animations:^{
      CGRect  Sframe = seachView.frame;
      Sframe.origin.y=0;
      seachView.frame=Sframe;
   } completion:^(BOOL finished) {
   }];

   
}


#pragma mark   -------------------searchBarDelegate--------------------
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
   //开始搜索 搜索完成刷新表格
 //  [self requestSearch];
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
