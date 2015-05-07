//
//  NewTableViewCell.h
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/4.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M80AttributedLabel.h"
#import "newModel.h"

typedef NS_ENUM(NSInteger,NSPageSourceType)
{
    NSPageTypeNewListController=100,
    NSPageTypeNewAllListController=102,
    NSPageTypeKnoleController=101,
};

@interface NewTableViewCell : UITableViewCell

{
    UILabel *titleLable;
    UIImageView  *logoImageView;
    UILabel  *tagLabel;
    UILabel  *authorLabel;
    UILabel  *countLabel;  //浏览次数
    UILabel *timeLabel;

}


@property (nonatomic,assign) NSPageSourceType    pageType;      //页面来源

@property(nonatomic,strong) newModel  *model;

@property(nonatomic,strong) M80AttributedLabel  *titlelabel;
-(void)setCellValueforRowIndex:(NSInteger) index;
@end
