//
//  YHDateViewController.m
//  TimePicker
//
//  Created by junde on 2017/3/19.
//  Copyright © 2017年 YYH. All rights reserved.
//

#import "YHDateViewController.h"
#import "YHDatePickerView.h"

@interface YHDateViewController ()
@property (nonatomic, strong) YHDatePickerView *datePickerView;

@end

@implementation YHDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义DatePickerView";
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:button];
    button.center = self.view.center;
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick:(UIButton *)button {
    NSDate *minLimitDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDate *maxLimitDate = [NSDate dateWithTimeIntervalSinceNow:86400 * 365 * 3];
    NSLog(@"minLimitDate -> %@, maxLimitDate-> %@",minLimitDate,maxLimitDate);
    self.datePickerView = [[YHDatePickerView alloc] initWithPickerStyle:YHDatePickerStyleYearMonthDayHourMinute maxLimitDate:maxLimitDate minLimitDate:minLimitDate completionHandler:^(NSDate *seletDate) {
        
        NSLog(@"--> %@",seletDate);
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        NSString *seletTimeStr = [formatter stringFromDate:seletDate];
        NSLog(@"--> %@",seletTimeStr);
    }];
    [self.datePickerView show];
    self.datePickerView.scrollDate = [NSDate dateWithTimeInterval: - 86400 * 369 * 20 sinceDate:[NSDate date]];
//    self.datePickerView.barTintColor = [UIColor redColor];
//    self.datePickerView.tintColor = [UIColor blueColor];
//    self.datePickerView.bottomViewBgColor = [UIColor darkGrayColor];
//    self.datePickerView.timeUnitLabelTextColor = [UIColor redColor];
}


@end
