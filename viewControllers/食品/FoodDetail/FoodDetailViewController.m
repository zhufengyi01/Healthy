//
//  FoodDetailViewController.m
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/9.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "ZCControl.h"
#import "Const.h"
#import "NetApi.h"
#import "newModel.h"
#import "AFNetworking.h"
#import "M80AttributedLabel.h"
#import "Helper.h"
#import "MMProgressHUD.h"
#import "UIImageView+WebCache.h"


@interface FoodDetailViewController ()
{
    UIImageView *logoImageView;
}
@property(strong,nonatomic)newModel  *model;
@property(strong,nonatomic)UILabel  *titleLable;
@property(strong,nonatomic)UILabel  *foodLable;




@property(strong,nonatomic)M80AttributedLabel  *contentLable;


@property(strong,nonatomic)UIScrollView   *scrollView;


@end

@implementation FoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =View_BackGround;
    [self createNavagtion];
    
    [self requestNewDetail];

    
}
-(void)createNavagtion
{
    UILabel  *titleLable=[ZCControl createLabelWithFrame:CGRectMake(0, 0, 100, 20) Font:16 Text:self.food_name];
    titleLable.textColor=[UIColor whiteColor];
    titleLable.font=[UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment=NSTextAlignmentCenter;
     self.navigationItem.titleView=titleLable;
}
-(void)requestNewDetail
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString;
         urlString =[NSString stringWithFormat:@"%@?id=%@",ApiFoodDetail,self.food_id];
    
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
-(void)creatUI
{
    
    self.scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0,64, kDeviceWidth, kDeviceHeight)];
    self.scrollView.contentSize=CGSizeMake(kDeviceWidth, 2*kDeviceHeight);
    //self.scrollView.backgroundColor =[UIColor redColor];
    self.scrollView.backgroundColor=View_BackGround;
    [self.view addSubview:self.scrollView];
    
    
    logoImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0,0,kDeviceWidth, 220)];
    logoImageView.layer.cornerRadius=4;
    logoImageView.backgroundColor =[UIColor blackColor];
    NSString  *imageurl =[NSString stringWithFormat:@"%@%@",ApiBase,self.model.img];
    [logoImageView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:nil];
  //  logoImageView.clipsToBounds=YES;
    [self.scrollView addSubview:logoImageView];
    
    

//    NSString  *titleString =self.model.title;
//    CGSize   Tsize =[titleString boundingRectWithSize:CGSizeMake(kDeviceWidth-20, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary  dictionaryWithObject:[UIFont systemFontOfSize:14]  forKey:NSFontAttributeName] context:nil].size;    //名
//    
    self.titleLable =[ZCControl createLabelWithFrame:CGRectMake(10, 10, kDeviceWidth-20, 30) Font:14 Text:self.model.title];
    self.titleLable.textColor=[UIColor blackColor];
    self.titleLable.text=self.model.name;
    self.titleLable.textAlignment=NSTextAlignmentCenter;
    self.titleLable.font=[UIFont boldSystemFontOfSize:18];
    self.titleLable.frame=CGRectMake(10,logoImageView.frame.origin.y+logoImageView.frame.size.height+0, kDeviceWidth-20,30);
    [self.scrollView addSubview:self.titleLable];
    
    
    
    //食材
    self.foodLable =[ZCControl createLabelWithFrame:CGRectMake(10, 10, kDeviceWidth-20, 30) Font:14 Text:self.model.food];
    self.foodLable.textColor=VGray_color;
     self.foodLable.textAlignment=NSTextAlignmentCenter;
    self.foodLable.font=[UIFont boldSystemFontOfSize:14];
    self.foodLable.frame=CGRectMake(10,self.titleLable.frame.origin.y+self.titleLable.frame.size.height+0, kDeviceWidth-20,30);
    [self.scrollView addSubview:self.foodLable];

    
    ///内容
    self.contentLable =[[M80AttributedLabel alloc]initWithFrame:CGRectMake(10,self.foodLable.frame.origin.y+self.foodLable.frame.size.height+10,kDeviceWidth-20,100)];
    self.contentLable.font=[UIFont systemFontOfSize:14];
    if (IsIphone6plus) {
        self.contentLable.font =[UIFont systemFontOfSize:16];
    }
    self.contentLable.textColor=VGray_color;
    self.contentLable.backgroundColor=[UIColor clearColor];
    self.contentLable.lineSpacing=0;
    [self.scrollView addSubview:self.contentLable];
    
    NSString  *ContentString = [Helper  filterHTML: self.model.message];
    ContentString =[ContentString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    [self.contentLable appendText:[Helper filterHTML:self.model.message]];
    self.titleLable.textAlignment=NSTextAlignmentCenter;
    
    CGSize   Csize =[ContentString boundingRectWithSize:CGSizeMake(kDeviceWidth-30, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary  dictionaryWithObject:self.contentLable.font  forKey:NSFontAttributeName] context:nil].size;
    self.contentLable.frame=CGRectMake(15, self.foodLable.frame.origin.y+self.foodLable.frame.size.height+0, kDeviceWidth-30, Csize.height+10);
    
    self.scrollView.contentSize=CGSizeMake(0, self.contentLable.frame.origin.y+self.contentLable.frame.size.height+100);

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
