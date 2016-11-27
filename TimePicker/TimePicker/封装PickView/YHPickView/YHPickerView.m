//
//  YHPickerView.m
//  TimePicker
//
//  Created by 杨应海 on 2016/11/27.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import "YHPickerView.h"

#define YHToolbarHeight 40

@interface YHPickerView ()

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate *defaultDate;
@property (nonatomic, assign) CGFloat pickerViewHeight;

@end


@implementation YHPickerView

- (instancetype)initDatePickerWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler {
 
    self = [super init];
    if (self) {
        _defaultDate = defaulDate;
        [self setUpDatePickerWithdatePickerMode:datePickerMode];
        [self setFrameWith:YES];
    }
    return self;
}

- (void)setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker.datePickerMode = datePickerMode;
    datePicker.backgroundColor = [UIColor lightGrayColor];
    if (_defaultDate) {
        datePicker.date = _defaultDate;
    }
    _datePicker = datePicker;
    datePicker.frame = CGRectMake(0, YHToolbarHeight, datePicker.frame.size.width, datePicker.frame.size.height);
    _pickerViewHeight = datePicker.frame.size.height;
    [self addSubview:datePicker];
}

- (void)setFrameWith:(BOOL)isHaveNavControler {
    CGFloat toolViewX = 0;
    CGFloat toolViewY;
    CGFloat toolViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat toolViewH = _pickerViewHeight + YHToolbarHeight;
    if (isHaveNavControler) {
        toolViewY = [UIScreen mainScreen].bounds.size.height - toolViewH - 49;
    } else {
        toolViewY = [UIScreen mainScreen].bounds.size.height - toolViewH;
    }
    self.frame = CGRectMake(toolViewX, toolViewY, toolViewW, toolViewH);
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)remove {
    [self removeFromSuperview];
}


@end
