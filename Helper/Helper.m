//
//  Helper.m
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/6.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#import "Helper.h"

@implementation Helper
+(BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

+(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
       html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@"   "];
    }
///NSString * regEx = @"<([^>]*)>";
   //     html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}
@end
