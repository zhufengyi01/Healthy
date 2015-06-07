//
//  FoodListTableViewCell.m
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/8.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import "FoodListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "newModel.h"
#import "ZCControl.h"
#import "Const.h"
#import "NetApi.h"

@implementation FoodListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];

    }
    return self;
}
-(void)createUI
{
   // self.nameLabel =[ZCControl createLabelWithFrame:CGRectMake(10, 0, kDeviceWidth-120, 40) Font:14 Text:@"haha"];
    self.nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(10,5, kDeviceWidth-120, 20)];
    self.nameLabel.font=[UIFont boldSystemFontOfSize:16];
    //self.nameLabel.textColor=VGray_color;
    [self.contentView addSubview:self.nameLabel];

    foodLable =[ZCControl createLabelWithFrame:CGRectMake(10,30, kDeviceWidth-100, 20) Font:14 Text:@"yoyo"];
    foodLable.font=[UIFont systemFontOfSize:14];
    foodLable.textColor=VGray_color;
    [self.contentView addSubview:foodLable];
    
    tagLabel =[ZCControl createLabelWithFrame:CGRectMake(10,55, kDeviceWidth-100, 30) Font:14 Text:@"yoyo"];
    tagLabel.font=[UIFont systemFontOfSize:12];
    tagLabel.textColor=VGray_color;
    tagLabel.numberOfLines=2;
    tagLabel.adjustsFontSizeToFitWidth=NO;
    tagLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    [self.contentView addSubview:tagLabel];
    
    logoImageView =[[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth-85,15, 80, 60)];
    logoImageView.layer.cornerRadius=4;
    logoImageView.clipsToBounds=YES;
    [self.contentView addSubview:logoImageView];
    

}
-(void)setCellValueForRowIndex:(NSInteger) index
{
    self.nameLabel.text=self.model.name;
    foodLable.text=[NSString stringWithFormat:@"食材:%@",self.model.food];
    tagLabel.text=[NSString stringWithFormat:@"%@",self.model.tag];
    NSString  *imageurl =[NSString stringWithFormat:@"%@%@",ApiBase,self.model.img];
    [logoImageView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:nil];

}
-(void)layoutSubviews{
    [super layoutSubviews];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
