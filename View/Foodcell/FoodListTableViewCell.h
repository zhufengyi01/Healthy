//
//  FoodListTableViewCell.h
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/8.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newModel.h"
typedef NS_ENUM(NSInteger,NSFoodPageSourceType)
{
    NSFoodPageSourceTypeFood
 };

@interface FoodListTableViewCell : UITableViewCell
{
 //   UILabel  *nameLabel;
    UILabel  *foodLable;
    UIImageView *logoImageView;
    UILabel   *tagLabel;
    
}

@property(nonatomic,strong) UILabel  *nameLabel;

@property(nonatomic,strong) newModel  *model;

-(void)setCellValueForRowIndex:(NSInteger) index;
@end
