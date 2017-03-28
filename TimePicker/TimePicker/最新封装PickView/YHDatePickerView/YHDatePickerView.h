//
//  YHDatePickerView.h
//  TimePicker
//
//  Created by junde on 2017/3/19.
//  Copyright © 2017年 YYH. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 风格枚举类型 */
typedef NS_ENUM (NSInteger, YHDatePickerStyle){
    YHDatePickerStyleYearMonthDayHourMinute,
    YHDatePickerStyleYearMonthDayHour,
    YHDatePickerStyleMonthDayHourMinute,
    YHDatePickerStyleYearMonthDay,
    YHDatePickerStyleMouthDay,
    YHDatePickerStyleHourMinute
};

@interface YHDatePickerView : UIView

/** 工具栏bar背景颜色 --> 默认亮灰色 */
@property (nonatomic, strong) UIColor *barTintColor;
/** 工具栏上字体颜色 --> 默认黑色 */
@property (nonatomic, strong) UIColor *tintColor;
/** pickerView背景颜色 --> 浅灰色 */
@property (nonatomic, strong) UIColor *bottomViewBgColor;
/** 日期对应的单位标签字体颜色 --> 默认橘色 */
@property (nonatomic, strong) UIColor *timeUnitLabelTextColor;

/** 初始显示的日期 -> 默认显示当前的时间 */
@property (nonatomic, copy) NSDate *scrollDate;


/** 初始化方法,要设置样式*/
- (instancetype)initWithPickerStyle:(YHDatePickerStyle)myDatePickerStyle;
/** 初始化之后显示 */
- (void)show;

@end
