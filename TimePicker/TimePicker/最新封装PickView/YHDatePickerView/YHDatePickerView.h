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

/** 初始显示的日期 -> 默认显示选中日期为 当前的时间 */
@property (nonatomic, copy) NSDate *scrollDate;

/**
 初始化方法
 @param myDatePickerStyle 选择的显示样式
 @param maxDate 最大限制日期,可以传 'nil' ,默认最大为 2049-12-31 23:59
 @param minDate 最小限制日期,可以传 'nil' ,默认最小为 1970-01-01 00:00
 @param complete 完成回调-->点击确定按钮之后回调选中日期
 @return 返回初始化好的自定义datePickerView视图
 */
- (instancetype)initWithPickerStyle:(YHDatePickerStyle)myDatePickerStyle maxLimitDate:(NSDate *)maxDate minLimitDate:(NSDate *)minDate completionHandler:(void(^)(NSDate *seletDate))complete;
/**
 初始化好了之后调用显示
 */
- (void)show;

@end
