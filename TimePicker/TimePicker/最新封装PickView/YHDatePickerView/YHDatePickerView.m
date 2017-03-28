
//
//  YHDatePickerView.m
//  TimePicker
//
//  Created by junde on 2017/3/19.
//  Copyright © 2017年 YYH. All rights reserved.
//

#import "YHDatePickerView.h"
#import "NSDate+category.h"

#define  screen_width    [UIScreen mainScreen].bounds.size.width
#define  screen_height   [UIScreen mainScreen].bounds.size.height
#define  MiniYear        1970  //默认最小年份
#define  MaxYear         2049  //默认最大年份

@interface YHDatePickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>
/** 日期存储数组 */
@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSMutableArray *monthArray;
@property (nonatomic, strong) NSMutableArray *dayArray;
@property (nonatomic, strong) NSMutableArray *hourArray;
@property (nonatomic, strong) NSMutableArray *minuteArray;
/** 记录日期数组对应的选取位置 */
@property (nonatomic, assign) NSInteger yearIndex;
@property (nonatomic, assign) NSInteger monthIndex;
@property (nonatomic, assign) NSInteger dayIndex;
@property (nonatomic, assign) NSInteger hourIndex;
@property (nonatomic, assign) NSInteger minuteIndex;

/** pickerView视图 */
@property (nonatomic, weak) UIPickerView *pickerView;

/** 枚举类型属性 */
@property (nonatomic, assign) YHDatePickerStyle myDatePickerViewStyle;
/** 最大时间限制 --> 默认 2049 */
@property (nonatomic, copy) NSDate *maxLimitDate;
/** 最小时间限制 --> 默认 1970 */
@property (nonatomic, copy) NSDate *minLimitDate;
/** 完成回调 block */
@property (nonatomic, copy) void(^complete)(NSDate *selectDate);
/** 显示的选中日期 */
@property (nonatomic, copy) NSDate *selectedDate;

/** 最底层内容背景视图 */
@property (nonatomic, weak) UIView *bgView;
/** 底部显示的年份标签 */
@property (nonatomic, weak) UILabel *yearLabel;
/** topBar背景视图 */
@property (nonatomic, weak) UIView *topBarBgView;
/** 取消按钮 */
@property (nonatomic, weak) UIButton *cancelButton;
/** 确定按钮 */
@property (nonatomic, weak) UIButton *sureButton;
/** pickerView的父视图 */
@property (nonatomic, weak) UIView *bottomContentView;


@end

@implementation YHDatePickerView

#pragma mark - 初始化方法
/** 初始化方法,要设置样式*/
- (instancetype)initWithPickerStyle:(YHDatePickerStyle)myDatePickerStyle maxLimitDate:(NSDate *)maxDate minLimitDate:(NSDate *)minDate completionHandler:(void (^)(NSDate *))complete{
    self = [super init];
    if (self) {
        
        self.myDatePickerViewStyle = myDatePickerStyle;
        self.maxLimitDate = maxDate;
        self.minLimitDate = minDate;
        if (complete) {
            self.complete = complete;
        }
    
        [self defalutConfiguration];
        [self setupUI];
    }
    return self;
}

#pragma mark - 重写书属性的setter方法
/** 滚动到指定日期 */
- (void)setScrollDate:(NSDate *)scrollDate {
    _scrollDate = scrollDate;
    [self scrollToDate:scrollDate animated:YES];
}

/** 设置工具栏的颜色 */
- (void)setBarTintColor:(UIColor *)barTintColor {
    _barTintColor = barTintColor;
    self.topBarBgView.backgroundColor = barTintColor;
}

/** 设置工具栏上 取消/确定 按钮的字体颜色 */
- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    [self.cancelButton setTitleColor:tintColor forState:UIControlStateNormal];
    [self.sureButton setTitleColor:tintColor forState:UIControlStateNormal];
}

/** 设置pickerView背景视图 */
- (void)setBottomViewBgColor:(UIColor *)bottomViewBgColor {
    _bottomViewBgColor = bottomViewBgColor;
    self.bottomContentView.backgroundColor = bottomViewBgColor;
}

/** 设置时间单位颜色 */
- (void)setTimeUnitLabelTextColor:(UIColor *)timeUnitLabelTextColor {
    _timeUnitLabelTextColor = timeUnitLabelTextColor;
    for (UIView *subView in self.yearLabel.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *subLabel = (UILabel *)subView;
            subLabel.textColor = timeUnitLabelTextColor;
        }
    }
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

/** 有三种返回每个component各行的title, 这里用代理方法中的第三种 */
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *reusingLabel = (UILabel *)view;
    if (!reusingLabel) {
        reusingLabel = [UILabel new];
        reusingLabel.textColor = [UIColor blackColor];
        reusingLabel.textAlignment = NSTextAlignmentCenter;
        reusingLabel.font = [UIFont systemFontOfSize:20];
    }
    
    NSString *textTitle = @"";
    switch (self.myDatePickerViewStyle) {
        case YHDatePickerStyleYearMonthDayHourMinute: //年 月 日 时 分
            if (component == 0) {
                textTitle = self.yearArray[row];
            }
            if (component == 1) {
                textTitle = self.monthArray[row];
            }
            if (component == 2) {
                textTitle = self.dayArray[row];
            }
            if (component == 3) {
                textTitle = self.hourArray[row];
            }
            if (component == 4) {
                textTitle = self.minuteArray[row];
            }
            break;
        case YHDatePickerStyleYearMonthDayHour: //年 月 日 时
            if (component == 0) {
                textTitle = self.yearArray[row];
            }
            if (component == 1) {
                textTitle = self.monthArray[row];
            }
            if (component == 2) {
                textTitle = self.dayArray[row];
            }
            if (component == 3) {
                textTitle = self.hourArray[row];
            }
            break;
        case YHDatePickerStyleMonthDayHourMinute: //月 日 时 分
            if (component == 0) {
                textTitle = self.monthArray[row];
            }
            if (component == 1) {
                textTitle = self.dayArray[row];
            }
            if (component == 2) {
                textTitle = self.hourArray[row];
            }
            if (component == 3) {
                textTitle = self.minuteArray[row];
            }
            break;
        case YHDatePickerStyleYearMonthDay:     //年 月 日
            if (component == 0) {
                textTitle = self.yearArray[row];
            }
            if (component == 1) {
                textTitle = self.monthArray[row];
            }
            if (component == 2) {
                textTitle = self.dayArray[row];
            }
            break;
        case YHDatePickerStyleMouthDay:         //月 日
            if (component == 0) {
                textTitle = self.monthArray[row];
            }
            if (component == 1) {
                textTitle = self.dayArray[row];
            }
            break;
        case YHDatePickerStyleHourMinute:        //时 分
            if (component == 0) {
                textTitle = self.hourArray[row];
            }
            if (component == 1) {
                textTitle = self.minuteArray[row];
            }
            break;
    }
    reusingLabel.text = textTitle;
    return reusingLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (self.myDatePickerViewStyle) {
        case YHDatePickerStyleYearMonthDayHourMinute:
        {
            if (component == 0) {
                self.yearIndex = row;
            } else if (component == 1) {
                self.monthIndex = row;
            } else if (component == 2) {
                self.dayIndex = row;
            } else if (component == 3) {
                self.hourIndex = row;
            } else if (component == 4) {
                self.minuteIndex = row;
            }
        }
            break;
        case YHDatePickerStyleYearMonthDayHour:
        {
            if (component == 0) {
                self.yearIndex = row;
            } else if (component == 1) {
                self.monthIndex = row;
            } else if (component == 2) {
                self.dayIndex = row;
            } else if (component == 3) {
                self.hourIndex = row;
            }
        }
            break;
        case YHDatePickerStyleMonthDayHourMinute:
        {
            if (component == 0) {
                self.monthIndex = row;
            } else if (component == 1) {
                self.dayIndex = row;
            } else if (component == 2) {
                self.hourIndex = row;
            } else if (component == 3) {
                self.minuteIndex = row;
            }
        }
            break;
        case YHDatePickerStyleYearMonthDay:
        {
            if (component == 0) {
                self.yearIndex = row;
            } else if (component == 1) {
                self.monthIndex = row;
            } else if (component == 2) {
                self.dayIndex = row;
            }
        }
            break;
        case YHDatePickerStyleMouthDay:
        {
            if (component == 0) {
                self.monthIndex = row;
            } else if (component == 1) {
                self.dayIndex = row;
            }
        }
            break;
        case YHDatePickerStyleHourMinute:
        {
            if (component == 0) {
                self.hourIndex = row;
            } else if (component == 1) {
                self.minuteIndex = row;
            }
        }
            break;
        default:
            break;
    }
    
    switch (self.myDatePickerViewStyle) {
        case YHDatePickerStyleYearMonthDayHourMinute:
        case YHDatePickerStyleYearMonthDayHour:
        case YHDatePickerStyleYearMonthDay:
            
            self.yearLabel.text = self.yearArray[self.yearIndex];
            
        case YHDatePickerStyleMonthDayHourMinute:
        case YHDatePickerStyleMouthDay:
//        case YHDatePickerStyleHourMinute:
            if (component == 0 || component == 1) {
                [self daysOfTheMonth:[self.monthArray[self.monthIndex] integerValue] InTheYear:[self.yearArray[self.yearIndex] integerValue]];
                if (self.dayArray.count - 1 < _dayIndex) {
                    _dayIndex = self.dayArray.count - 1;
                }
            }
            break;
            
        default:
            break;
    }

    [self.pickerView reloadAllComponents];
    

    // 设置选中的日期,用于确定的时候回调
    NSString *selectedDateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",self.yearArray[self.yearIndex],self.monthArray[self.monthIndex],self.dayArray[self.dayIndex],self.hourArray[self.hourIndex],self.minuteArray[self.minuteIndex]];
//    NSLog(@"dateStr -> %@", selectedDateStr);
    self.selectedDate = [NSDate date:selectedDateStr withFormat:@"yyyy-MM-dd HH:mm"];
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    switch (self.myDatePickerViewStyle) {
        case YHDatePickerStyleYearMonthDayHourMinute:
            [self addTimeUnitLabelWithArray:@[@"年",@"月",@"日",@"时",@"分"]];
            return 5;
        case YHDatePickerStyleYearMonthDayHour:
            [self addTimeUnitLabelWithArray:@[@"年",@"月",@"日",@"时"]];
            return 4;
        case YHDatePickerStyleMonthDayHourMinute:
            [self addTimeUnitLabelWithArray:@[@"月",@"日",@"时",@"分"]];
            return 4;
        case YHDatePickerStyleYearMonthDay:
            [self addTimeUnitLabelWithArray:@[@"年",@"月",@"日"]];
            return 3;
        case YHDatePickerStyleMouthDay:
            [self addTimeUnitLabelWithArray:@[@"月",@"日"]];
            return 2;
        case YHDatePickerStyleHourMinute:
            [self addTimeUnitLabelWithArray:@[@"时",@"分"]];
            return 2;
        default:
            return 0;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    // 所有component对应行数数组
    NSArray *componentsDataArray = [self getDateDataArrayOfComponents];
    // 每个component对应的行数
    NSInteger rows = [componentsDataArray[component] integerValue];
    return rows;
}


#pragma mark - 计算不同 pickerStyle 下对应的日期数据数组
- (NSArray *)getDateDataArrayOfComponents {
    NSInteger yearCount = self.yearArray.count;
    NSInteger monthCount = self.monthArray.count;
    NSInteger hourCount = self.hourArray.count;
    NSInteger miniteCount = self.minuteArray.count;
    // 当每次滚动的时候刷新数据源 -> 都会走这个方法,然后走这句代码,
    //                       -> 保存天数的数组刷新了,改年该月对应的天数也刷新了
    NSInteger dayCount = [self daysOfTheMonth:[self.monthArray[self.monthIndex] integerValue] InTheYear:[self.yearArray[self.yearIndex] integerValue]];
    
    switch (self.myDatePickerViewStyle) {
        case YHDatePickerStyleYearMonthDayHourMinute:
            return @[@(yearCount),@(monthCount),@(dayCount),@(hourCount),@(miniteCount)];
        case YHDatePickerStyleYearMonthDayHour:
            return @[@(yearCount),@(monthCount),@(dayCount),@(hourCount)];
        case YHDatePickerStyleMonthDayHourMinute:
            return @[@(monthCount),@(dayCount),@(hourCount),@(miniteCount)];
        case YHDatePickerStyleYearMonthDay:
            return @[@(yearCount),@(monthCount),@(dayCount)];
        case YHDatePickerStyleMouthDay:
            return @[@(monthCount),@(dayCount)];
        case YHDatePickerStyleHourMinute:
            return @[@(hourCount),@(miniteCount)];
        default:
            break;
    }
    
}


#pragma mark - 根据年月求得该年该月有多少天
/** 方法返回的是该年该月对应的天数,同时也设置对应的该月的天数数组 */
- (NSInteger)daysOfTheMonth:(NSInteger)month InTheYear:(NSInteger)year {
    // 四年一闰,百年不闰,四百年再闰
    BOOL IsBissextile = NO;
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        IsBissextile = YES;
    }
    [self.dayArray removeAllObjects];
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            for (NSInteger i = 1; i <= 31 ; i++) {
                [self.dayArray addObject:[NSString stringWithFormat:@"%02zd", i]];
            }
            return 31;
        case 4: case 6: case 9: case 11:
            for (NSInteger i = 1; i <= 30; i++) {
                [self.dayArray addObject:[NSString stringWithFormat:@"%02zd", i]];
            }
            return 30;
        case 2:
            if (IsBissextile) {
                for (NSInteger i = 1; i <= 29; i++) {
                    [self.dayArray addObject:[NSString stringWithFormat:@"%02zd", i]];
                }
                return 29;
            } else {
                for (NSInteger i = 1; i <= 28; i++) {
                    [self.dayArray addObject:[NSString stringWithFormat:@"%02zd", i]];
                }
                return 28;
            }
    }
    return 0;
}


#pragma mark - 添加'时间对应的单位'标签
- (void)addTimeUnitLabelWithArray:(NSArray *)unitArray {
    for (UIView *subView in self.yearLabel.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    // 中间向右便宜量 和 大小
    CGFloat offsetCenterX = 18;
    CGFloat labelWH = 16;
    for (NSInteger index = 0; index < unitArray.count; index++) {
        CGFloat offsetX = screen_width / (unitArray.count * 2) + offsetCenterX + screen_width / unitArray.count * index;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, self.yearLabel.bounds.size.height / 2 - labelWH, labelWH, labelWH)];
        label.text = unitArray[index];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = self.timeUnitLabelTextColor;
        [self.yearLabel addSubview:label];
    }
}

#pragma mark - 确定按钮的点击方法
- (void)sureButtonClick {
    if (self.complete) {
        if (!self.selectedDate) {
            self.selectedDate = [NSDate date];
        }
        self.complete(self.selectedDate);
    }
    
    [self dimiss];
}

#pragma mark - 取消按钮/点按手势的点击方法
- (void)dimiss {
    [UIView animateWithDuration:.25 animations:^{
        self.bgView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 初始化之后显示调用的方法
- (void)show {
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    CGFloat height = 264;
    CGAffineTransform transform = self.bgView.transform;
    transform = CGAffineTransformMakeTranslation(0, - height);
    [UIView animateWithDuration:.25 animations:^{
        self.bgView.transform = transform;
    }];
}

#pragma mark - 默认配置信息
- (void)defalutConfiguration {
    if (!self.barTintColor) {
        _barTintColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    }
    if (!self.tintColor) {
        _tintColor = [UIColor blackColor];
    }
    if (!self.bottomViewBgColor) {
        _bottomViewBgColor = [UIColor colorWithRed:216 / 255.0 green:219 / 255.0 blue:223 / 255.0 alpha:1.0];
    }
    if (!self.timeUnitLabelTextColor) {
        _timeUnitLabelTextColor = [UIColor orangeColor];
    }
    
    if (!self.maxLimitDate) {
        _maxLimitDate = [NSDate date:@"2049-12-31 23:59" withFormat:@"yyyy-MM-dd HH:mm"];
    }
    if (!self.minLimitDate) {
        _minLimitDate = [NSDate dateWithTimeIntervalSince1970:0];
    }
    
    // 初始化数组 -->作为数据源
    _yearArray = [NSMutableArray array];
    _monthArray = [NSMutableArray array];
    _dayArray = [NSMutableArray array];
    _hourArray = [NSMutableArray array];
    _minuteArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 60; i++) {
        NSString *numStr = [NSString stringWithFormat:@"%02zd", i];
        if (i > 0 && i <= 12) {
            [_monthArray addObject:numStr]; // 月份-->每年都一样
        }
        if (i < 24) {
            [_hourArray addObject:numStr];  // 小时-->每天都一样
        }
        [_minuteArray addObject:numStr];    // 分钟-->每小时都一样
    }
    for (NSInteger i = MiniYear; i <= MaxYear; i++) {
        NSString *numStr = [NSString stringWithFormat:@"%02zd", i];
        [_yearArray addObject:numStr];      // 默认一共多少年
    }

}




#pragma mark - 滚动到对应时间的位置,默认为滚动到当前时间
- (void)scrollToDate:(NSDate *)date animated:(BOOL)animated {
    if (!date) {
        date = [NSDate date];
    }
    [self daysOfTheMonth:date.month InTheYear:date.year];
    
    self.yearIndex = date.year - MiniYear;
    self.monthIndex = date.month - 1;
    self.dayIndex = date.day - 1;
    self.hourIndex = date.hour;
    self.minuteIndex = date.minute;
    
    self.yearLabel.text = @(date.year).description;
//    self.yearLabel = self.yearArray[self.yearIndex];
    // 判断不同状态下的时间下标数组
    NSArray *indexArray = nil;
    switch (self.myDatePickerViewStyle) {
        case YHDatePickerStyleYearMonthDayHourMinute:
            indexArray = @[@(self.yearIndex),@(self.monthIndex),@(self.dayIndex),@(self.hourIndex),@(self.minuteIndex)];
            break;
        case YHDatePickerStyleYearMonthDayHour:
            indexArray = @[@(self.yearIndex),@(self.monthIndex),@(self.dayIndex),@(self.hourIndex)];
            break;
        case YHDatePickerStyleMonthDayHourMinute:
            indexArray = @[@(self.monthIndex),@(self.dayIndex),@(self.hourIndex),@(self.minuteIndex)];
            break;
        case YHDatePickerStyleYearMonthDay:
            indexArray = @[@(self.yearIndex),@(self.monthIndex),@(self.dayIndex)];
            break;
        case YHDatePickerStyleMouthDay:
            indexArray = @[@(self.monthIndex),@(self.dayIndex)];
            break;
        case YHDatePickerStyleHourMinute:
            indexArray = @[@(self.hourIndex),@(self.minuteIndex)];
            break;
        default:
            break;
    }

    [self.pickerView reloadAllComponents];
    for (NSInteger index = 0; index < indexArray.count; index++) {
        NSInteger component = index;
        NSInteger row = [indexArray[index] integerValue];
//        NSLog(@"row - %zd --- component - %zd", row, component);
        [self.pickerView selectRow:row inComponent:component animated:NO];
    }
}

#pragma mark - 设置界面元素
- (void)setupUI {
    self.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
    self.frame = CGRectMake(0, 0, screen_width, screen_height);

    CGFloat height = 264;
    CGFloat topBar_height = 44;
    
    // 1> 添加一个最底层的背景视图
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height, screen_width, height)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    // 2> 添加 取消 / 确定按钮 以及 背景视图
    UIView *topBarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, topBar_height)];
    topBarBgView.backgroundColor = self.barTintColor;
    [bgView addSubview:topBarBgView];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, topBar_height)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:self.tintColor forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(dimiss) forControlEvents:UIControlEventTouchUpInside];
    [topBarBgView addSubview:cancelButton];
    
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(screen_width - 60, 0, 60, topBar_height)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:self.tintColor forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [topBarBgView addSubview:sureButton];
    
    // 3> 添加底部内容视图
    UIView *bottomContentView = [[UIView alloc] initWithFrame:CGRectMake(0, topBar_height, screen_width, height - topBar_height)];
    bottomContentView.backgroundColor = self.bottomViewBgColor;
    [bgView addSubview:bottomContentView];
    
    UILabel *yearLabel = [[UILabel alloc] initWithFrame:bottomContentView.bounds];
    yearLabel.textColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1.0];
    yearLabel.textAlignment = NSTextAlignmentCenter;
    yearLabel.text = @"2016";
    yearLabel.font = [UIFont systemFontOfSize:110];
    [bottomContentView addSubview:yearLabel];
    
    // pickerView
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:bottomContentView.bounds];
    pickerView.delegate = self;
    pickerView.dataSource = self;
//    [pickerView selectRow:0 inComponent:0 animated:YES];// 如果初始的时候没有设置选择一行,不会显示中间两条线

    pickerView.showsSelectionIndicator = YES;
    [bottomContentView addSubview:pickerView];
    
    // 4> 添加点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimiss)];
    [self addGestureRecognizer:tapGesture];
    
    // 5> 属性记录
    _bgView = bgView;
    _yearLabel = yearLabel;
    _topBarBgView = topBarBgView;
    _cancelButton = cancelButton;
    _sureButton = sureButton;
    _pickerView = pickerView;
    _bottomContentView = bottomContentView;
    
    // 6> 默认滚动到当前日期
    [self scrollToDate:nil animated:YES];
}




@end
