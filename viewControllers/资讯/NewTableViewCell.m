//
//  NewTableViewCell.m
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/4.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import "NewTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "newModel.h"
#import "ZCControl.h"
#import "Const.h"
#import "NetApi.h"
@implementation NewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
    
}
-(void)createUI
{
    titleLable =[ZCControl createLabelWithFrame:CGRectMake(10, 0, kDeviceWidth-120, 40) Font:14 Text:@""];
    titleLable.font=[UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:titleLable];
    
    tagLabel =[ZCControl createLabelWithFrame:CGRectMake(10,60, 40, 15) Font:10 Text:@""];
    tagLabel.backgroundColor=VGray_color;
    tagLabel.layer.cornerRadius=2;
    tagLabel.clipsToBounds=YES;
    tagLabel.textColor=[UIColor whiteColor];
    [self.contentView addSubview:tagLabel];
    
    countLabel =[ZCControl createLabelWithFrame:CGRectMake(70,60,80, 20) Font:12 Text:@""];
    countLabel.textColor=VGray_color;
    [self.contentView addSubview:countLabel];
    
    timeLabel =[ZCControl createLabelWithFrame:CGRectMake(10,80,120, 20) Font:10 Text:@""];
    timeLabel.textColor=VGray_color;
    [self.contentView addSubview:timeLabel];
    
    logoImageView =[[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth-85,10, 80, 60)];
    logoImageView.layer.cornerRadius=4;
    logoImageView.clipsToBounds=YES;
    [self.contentView addSubview:logoImageView];
    
}

-(void)setCellValueforRowIndex:(NSInteger) index
{
    titleLable.text=self.model.title;
    NSString  *imageurl =[NSString stringWithFormat:@"%@%@",ApiBase,self.model.img];
    [logoImageView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:nil];
    if (self.pageType==NSPageTypeNewAllListController||self.pageType==NSPageTypeNewListController) {
        tagLabel.text=self.model.tag;

    }
    else if(self.pageType==NSPageTypeKnoleController)
    {
        tagLabel.text=self.model.className;
        
    }
    countLabel.text=[NSString stringWithFormat:@"共浏览:%@",self.model.count];
    
    NSString *timeStr=self.model.time;
    timeLabel.text=[NSString stringWithFormat:@"%@",timeStr];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.model.img.length==0||!self.model.img) {
        //titleLable.frame=CGRectMake(10,0,kDeviceWidth-20,40);
        //logoImageView.frame=CGRectZero;
    }
    
    NSString  *titleStr =self.model.title;
    CGSize  size =[titleStr boundingRectWithSize:CGSizeMake(kDeviceWidth-100, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObject:titleLable.font forKey:NSFontAttributeName] context:nil].size;
    titleLable.frame=CGRectMake(10, 0, kDeviceWidth-100, size.height+5);
    
    countLabel.frame=CGRectMake(10, self.frame.size.height-20, 80, 20);
    tagLabel.frame=CGRectMake(10,self.frame.size.height-40, 40, 20);
    timeLabel.frame=CGRectMake(countLabel.frame.origin.x+countLabel.frame.size.width, self.frame.size.height-20, 100, 20);
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
