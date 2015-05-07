//
//  CustomTabBar.h
//  CustomTabBar
//
//  Created by qianfeng on 14-8-30.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTabBarDelegate <NSObject>
//代理方法
- (void)buttonPresedInCustomTabBar:(NSUInteger)index;

@end

@interface CustomTabBar : UIView
@property (nonatomic, weak) id <CustomTabBarDelegate> m_delegate;
@end
