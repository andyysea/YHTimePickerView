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
    
//    if (self.datePickerView == nil) {
        self.datePickerView = [[YHDatePickerView alloc] initWithPickerStyle:YHDatePickerStyleYearMonthDay];
//    }
    //[self.view addSubview:self.datePickerView];
   // self.datePickerView.timeUnitLabelTextColor = [UIColor whiteColor];
    [self.datePickerView show];
//    self.datePickerView.scrollDate = [NSDate dateWithTimeInterval:86400 sinceDate:[NSDate date]];
}


@end
