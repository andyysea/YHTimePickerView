//
//  NSDate+category.m
//  TimePicker
//
//  Created by junde on 2017/3/22.
//  Copyright © 2017年 YYH. All rights reserved.
//

#import "NSDate+category.h"

static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (category)

+ (NSCalendar *) currentCalendar {
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

#pragma mark - 时间对应的年
-(NSInteger)year {
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}

#pragma mark - 时间对应的月
- (NSInteger)month {
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

#pragma mark - 时间对应的日
- (NSInteger)day {
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

#pragma mark - 时间对应的小时
- (NSInteger)hour {
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

#pragma mark - 时间对应的小时
- (NSInteger)minute {
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}


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
