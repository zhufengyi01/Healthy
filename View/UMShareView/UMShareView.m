//
//  UMShareView.m
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/6/7.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import "UMShareView.h"
#import "ZCControl.h"
#import "Const.h"
@implementation UMShareView

-(instancetype)initWithTitleWith:(NSString *) title delegate:(id) delegate;
{
    if (self =[super init]) {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.frame=CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
        [self creatUI];
        _titleString=title;
        _delegate=delegate;
        
        UITapGestureRecognizer  *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CancleShareClick)];
        [self addGestureRecognizer:tap];
        
        
    }
    return self;
}

-(void)creatUI
{
     backView =[[UIView alloc]initWithFrame:CGRectMake(0, kDeviceHeight, kDeviceWidth, kDeviceWidth/4+40+60)];
    backView.backgroundColor =[UIColor whiteColor];
    backView.userInteractionEnabled=YES;
    [self addSubview:backView];
    
    UITapGestureRecognizer  *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Click)];
    [backView addGestureRecognizer:tap];
    

    
    
    UILabel  *label =[ZCControl createLabelWithFrame:CGRectMake(0, 0, kDeviceWidth, 40) Font:14 Text:@"分享"];
    
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=VGray_color;
    [backView addSubview:label];
    
    
    NSArray  *imageArray=[NSArray arrayWithObjects:@"moments_share_icon.png",@"wechat_share_icon.png",@"qzone_share_icon.png", @"weibo_share_icon.png", nil];
     for (int i=0; i<4; i++) {
        double   x=(kDeviceWidth/4)*i;
        double   y=40;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setFrame:CGRectMake(x,y, kDeviceWidth/4, kDeviceWidth/4) ImageName:imageArray[i] Target:self Action:@selector(handShareButtonClick:) Title:titleArray[i] Font:12];
        btn.frame =CGRectMake(x, y, kDeviceWidth/4, kDeviceWidth/4);
        btn.tag=10000+i;
        [btn setTitleColor:VBlue_color forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor whiteColor];
         [btn addTarget:self action:@selector(sharebuttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
    }
    
    UIButton  *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:VGray_color forState:UIControlStateNormal];
    button.frame=CGRectMake(20, backView.frame.size.height-50, kDeviceWidth-40, 35);
    button.titleLabel.font =[UIFont systemFontOfSize:14];
    [button setBackgroundImage:[UIImage imageNamed:@"view_withe_backgroud.png"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 3;
    button.layer.borderWidth=1;
    button.layer.borderColor=VLight_GrayColor.CGColor;
    [button addTarget:self action:@selector(CancleShareClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button];
}
-(void)sharebuttonClick:(UIButton *) btn
{
    NSInteger  index=btn.tag-10000;
    [self removeFromSuperview];
    if (_delegate &&[_delegate respondsToSelector:@selector(UMShareViewClickIndex:)]) {
        [_delegate UMShareViewClickIndex:index];
    }
    
}

-(void)show
{
    [AppWindow addSubview:self];
    [UIView animateWithDuration:0.4 animations:^{
        backView.frame=CGRectMake(0, kDeviceHeight-(kDeviceWidth/4+40)-60, kDeviceWidth, kDeviceWidth/4+40+60);
        self.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.2];
        
    } completion:^(BOOL finished) {
        
        
    }];
}
-(void)Click
{
    
}
-(void)CancleShareClick
{
    [UIView animateWithDuration:0.4 animations:^{
        backView.frame=CGRectMake(0, kDeviceHeight, kDeviceWidth, kDeviceWidth/4+40);
        self.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0];

        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
