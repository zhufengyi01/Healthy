//
//  Helper.h
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/6.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject
//邮箱验证
+(BOOL) validateEmail: (NSString *) candidate;

// 去掉网页附带的标签
+(NSString *)filterHTML:(NSString *)html;

@end
