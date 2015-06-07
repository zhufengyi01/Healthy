//
//  UMShareView.h
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/6/7.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UMShareViewDelegate <NSObject>

-(void)UMShareViewClickIndex:(NSInteger) buttonIndex;

@end
@interface UMShareView : UIView
{
    UIView  *backView ;
    NSString  *_titleString;
    id <UMShareViewDelegate> _delegate;
}
-(instancetype)initWithTitleWith:(NSString *) title delegate:(id) delegate;

-(void)show;
@end
