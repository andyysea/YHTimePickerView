//
//  ViewController.m
//  TimePicker
//
//  Created by 杨应海 on 2016/11/14.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import "ViewController.h"
#import "YHToolbar.h"


@interface ViewController () <UITextFieldDelegate, YHToolbarDelegate>

@property (nonatomic, weak) UITextField *oneField;

@property (nonatomic, weak) UITextField *twoField;

@property (nonatomic, weak) YHToolbar *toolbar;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong) NSArray *textFieldArray;


@property (nonatomic, strong) UIDatePicker *datePicker;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


#pragma mark - 设置界面
- (void)setupUI {
    
    
    
    UITextField *oneField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 200, 40)];
    oneField.backgroundColor = [UIColor lightGrayColor];
    oneField.textColor = [UIColor redColor];
    [self.view addSubview:oneField];
    
    UITextField *twoField = [[UITextField alloc] initWithFrame:CGRectMake(50, 200, 200, 40)];
    twoField.backgroundColor = [UIColor lightGrayColor];
    twoField.textColor = [UIColor redColor];
    [self.view addSubview:twoField];
    
    _oneField = oneField;
    _twoField = twoField;
    
    // 将文本框放入数组
    _textFieldArray = @[self.oneField, self.twoField];
    
    // 设置文本框代理
    oneField.delegate = self;
    twoField.delegate = self;
    
    
    // 创建datepicker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    // 设置语言
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
    // 设置样式
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    
    // 这句代码是为了设置最小可以选中的时间是当前日期
    datePicker.minimumDate = [NSDate date];  // --> 不能把这句代码放在监听方法里面,飞则没有效果
    // 也可以设置最大选择日期 --> 从现在到未来一周内的时间限制
    datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:7 * 24 * 60 * 60];
    
    
    // 监听事件
    [datePicker addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];
    
    _datePicker = datePicker;
    
    
    
    // 创建toolbar ----> 注意要给个大小
    YHToolbar *toolbar = [[YHToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44)];
    toolbar.yhdelegate = self;
    
    _toolbar = toolbar;
    
    // 设置输入视图
    oneField.inputView = datePicker;
    twoField.inputView = datePicker;
    
    // 设置辅助视图
    oneField.inputAccessoryView = toolbar;
    twoField.inputAccessoryView = toolbar;
   
}

- (void)toolbar:(YHToolbar *)toolbar withType:(YHToolbarType)type {
    switch (type) {
        case YHToolbarTypeCancel:
            [self.view endEditing:YES];
            break;
            
        case YHToolbarTypeSure:
            
//            _oneField.text = _time;
            if ([_oneField isEditing]) {
                _oneField.text = _time;
                
            } else if ([_twoField isEditing]) {
                _twoField.text = _time;
            }
            
            
            [self.view endEditing:YES];
            break;
    }
}





- (void)timeChange:(UIDatePicker *)datepicker {
    
    NSDate *date = datepicker.date;// datepicker默认就是系统的当前时间
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *time = [formatter stringFromDate:date];
    

    // 记录时间
    _time = time;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    

    if ([textField isEqual:self.textFieldArray[0]]) {
        [_twoField resignFirstResponder];
        [_oneField becomeFirstResponder];
        
    } else {
        [_oneField resignFirstResponder];
        [_twoField becomeFirstResponder];
    }
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
