//
//  NeDetailViewController.h
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/5.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,NSDetailPageSourceType)
{
    NSDetailPageTypeNewListController=100,
  //  NSDetailPageTypeNewAllListController=102,
    NSDetailPageTypeKnoleController=101,
};

@interface NeDetailViewController : UIViewController

@property(nonatomic,strong) NSString  *detailId;

@property(nonatomic,strong) NSString  *detailName;


@property (nonatomic,assign) NSDetailPageSourceType    pageType;      //页面来源

@end
