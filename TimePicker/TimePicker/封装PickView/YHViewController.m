//
//  YHViewController.m
//  TimePicker
//
//  Created by 杨应海 on 2016/11/27.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import "YHViewController.h"
#import "YHPickerView.h"

@interface YHViewController ()

@end

@implementation YHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPickerView;
    UIDatePicker;
    
    YHPickerView *pickerView = [[YHPickerView alloc] initDatePickerWithDate:[NSDate date] datePickerMode:UIDatePickerModeDate isHaveNavControler:YES];
    [pickerView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
