//
//  NSDate+category.m
//  TimePicker
//
//  Created by junde on 2017/3/22.
//  Copyright © 2017年 YYH. All rights reserved.
//

#import "NSDate+category.h"

@implementation NSDate (category)


#pragma mark - 给定的时间字符串和日期格式返回日期
+ (NSDate *)date:(NSString *)datestr withFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:datestr];
    return date;
}


@end
