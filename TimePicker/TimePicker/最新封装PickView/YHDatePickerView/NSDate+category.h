//
//  NSDate+category.h
//  TimePicker
//
//  Created by junde on 2017/3/22.
//  Copyright © 2017年 YYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (category)

/** 时间对应的年 */
@property (readonly) NSInteger year;
/** 时间对应的月 */
@property (readonly) NSInteger month;
/** 时间对应的日 */
@property (readonly) NSInteger day;
/** 时间对应的日 */
@property (readonly) NSInteger hour;
/** 时间对应的日 */
@property (readonly) NSInteger minute;


/** 给定的时间字符串和日期格式返回日期 */
+ (NSDate *)date:(NSString *)datestr withFormat:(NSString *)format;


@end
