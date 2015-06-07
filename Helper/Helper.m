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
+(NSString *) dateFromDateSting:(NSString *) date;
{
    
    NSString *str;
    NSArray  *dateArray =@[@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec"];
  //  for (int i=0; i<dateArray.count; i++) {
        str=[date stringByReplacingOccurrencesOfString:dateArray[0] withString:@"01月"];
        str=[str stringByReplacingOccurrencesOfString:dateArray[1] withString:@"02月"];
        str=[str stringByReplacingOccurrencesOfString:dateArray[2] withString:@"03月"];
        str=[str stringByReplacingOccurrencesOfString:dateArray[3] withString:@"04月"];
        str=[str stringByReplacingOccurrencesOfString:dateArray[4] withString:@"05月"];
        str=[str stringByReplacingOccurrencesOfString:dateArray[5] withString:@"06月"];
        str=[str stringByReplacingOccurrencesOfString:dateArray[6] withString:@"07月"];
        str=[str stringByReplacingOccurrencesOfString:dateArray[7] withString:@"08月"];
        str=[str stringByReplacingOccurrencesOfString:dateArray[8] withString:@"09月"];
        str=[str stringByReplacingOccurrencesOfString:dateArray[9] withString:@"10月"];
        str=[str stringByReplacingOccurrencesOfString:dateArray[10] withString:@"11月"];
        str=[str stringByReplacingOccurrencesOfString:dateArray[11] withString:@"12月"];
        str =[str stringByReplacingOccurrencesOfString:@"2015" withString:@" "];
        str = [str stringByReplacingOccurrencesOfString:@"2014" withString:@" "];
        str= [str stringByReplacingOccurrencesOfString:@"AM" withString:@"上午"];
        str =[str stringByReplacingOccurrencesOfString:@"PM" withString:@"下午"];
        str =[str stringByReplacingOccurrencesOfString:@"," withString:@"日"];
        //str=[str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
   // }
    return str;
}

@end
