//
//  Header.h
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/4.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#ifndef ________Header_h
#define ________Header_h

#pragma  mark    宽高设置
#define kDeviceWidth        [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight       [UIScreen mainScreen].bounds.size.height
#define IsIphone6                [UIScreen mainScreen].bounds.size.height==667
#define IsIphone6plus            [UIScreen mainScreen].bounds.size.height==736



//项目背景颜色
#define View_BackGround [UIColor colorWithRed:250.0/255 green:250.0/255 blue:250.0/255 alpha:1]
#define VLight_GrayColor [UIColor colorWithRed:188.0/255 green:188.0/255 blue:188.0/255 alpha:1]
//字体深灰色
#define VGray_color      [UIColor colorWithRed:127.0/255 green:127.0/255 blue:139.0/255 alpha:1]
//字体蓝色
#define VBlue_color [UIColor colorWithRed:0/255 green:146.0/255 blue:255.0/255 alpha:1]

#define View_ToolBar   [UIColor colorWithRed:250.0/255 green:250.0/255 blue:250.0/255 alpha:1]

#define kHeightNavigation 64
#define kHeigthTabBar     49

#define AppWindow  [[[UIApplication sharedApplication ] delegate] window]


#endif
