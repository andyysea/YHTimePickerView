//
//  YHPickerView.m
//  TimePicker
//
//  Created by 杨应海 on 2016/11/27.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import "YHPickerView.h"

#define YHToolbarHeight 40
#define Screen_Width [UIScreen mainScreen].bounds.size.width


@interface YHPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, copy) NSString *plistName;

@property (nonatomic, strong) NSArray *plistArray;
@property (nonatomic, assign) BOOL isLevelArray;
@property (nonatomic, assign) BOOL isLevelString;
@property (nonatomic, assign) BOOL isLevelDic;
@property (nonatomic, strong) NSDictionary *levelTwoDic;

@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate *defaultDate;
@property (nonatomic, assign) BOOL isHaveNavController;
@property (nonatomic, assign) CGFloat pickerViewHeight;

@property (nonatomic, copy) NSString *resultString;

@property (nonatomic, strong) NSMutableArray *componentArray;
@property (nonatomic, strong) NSMutableArray *dicKeyArray;
@property (nonatomic, copy) NSMutableArray *state;
@property (nonatomic, copy) NSMutableArray *city;

@end


@implementation YHPickerView

#pragma mark - 懒加载
-(NSArray *)plistArray{
    
    if (_plistArray==nil) {
        _plistArray=[[NSArray alloc] init];
    }
    return _plistArray;
}

-(NSArray *)componentArray{
    
    if (_componentArray==nil) {
        _componentArray=[[NSMutableArray alloc] init];
    }
    return _componentArray;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupToolbar];
    }
    return self;
}


- (instancetype)initPickerViewWithPlistName:(NSString *)plistName isHaveNavController:(BOOL)isHaveNavControler {
  
    self = [super init];
    if (self) {
        _plistName = plistName;
        self.plistArray = [self getPlistArrayByPlistName:plistName];
        [self setUpPickView];
        [self setFrameWith:isHaveNavControler];
    }
    return self;
}




- (instancetype)initPickerViewWithArray:(NSArray *)array isHaveNavController:(BOOL)isHaveNavController {
    
    self = [super init];
    if (self) {
        self.plistArray = array;
        [self setArrayClass:array];
        [self setUpPickView];
        [self setFrameWith:isHaveNavController];
    }
    return self;
}


- (instancetype)initDatePickerWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler {
 
    self = [super init];
    if (self) {
        _defaultDate = defaulDate;
        [self setUpDatePickerWithdatePickerMode:datePickerMode];
        [self setFrameWith:isHaveNavControler];
    }
    return self;
}

- (NSArray *)getPlistArrayByPlistName:(NSString *)plistName {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
    [self setArrayClass:array];
    return array;
}


- (void)setArrayClass:(NSArray *)array {
    
    _dicKeyArray = [[NSMutableArray alloc] init];
    for (id levelTwo in array) {
        
        if ([levelTwo isKindOfClass:[NSArray class]]) {
            _isLevelArray = YES;
            _isLevelString = NO;
            _isLevelDic = NO;
        } else if ([levelTwo isKindOfClass:[NSString class]]) {
            _isLevelString = YES;
            _isLevelArray = NO;
            _isLevelDic = NO;
        } else if ([levelTwo isKindOfClass:[NSDictionary class]]) {
            _isLevelDic = YES;
            _isLevelString = NO;
            _isLevelArray = NO;
            
            _levelTwoDic = levelTwo;
            [_dicKeyArray addObject:[_levelTwoDic allKeys]];
        }
    }
    
}




- (void)setUpPickView {
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.backgroundColor = [UIColor lightGrayColor];
    _pickerView = pickerView;
    pickerView.showsSelectionIndicator = YES;
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.frame = CGRectMake(0, YHToolbarHeight, Screen_Width, pickerView.frame.size.height);
    _pickerViewHeight = pickerView.frame.size.height;
    [self addSubview:pickerView];
}


- (void)setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker.datePickerMode = datePickerMode;
    datePicker.backgroundColor = [UIColor lightGrayColor];
    if (_defaultDate) {
        [datePicker setDate:_defaultDate];
    }
    _datePicker = datePicker;
    datePicker.frame = CGRectMake(0, YHToolbarHeight,Screen_Width, datePicker.frame.size.height);
    _pickerViewHeight = datePicker.frame.size.height;
    [self addSubview:datePicker];
}

- (void)setFrameWith:(BOOL)isHaveNavControler {
    CGFloat toolViewX = 0;
    CGFloat toolViewY;
    CGFloat toolViewW = Screen_Width;
    CGFloat toolViewH = _pickerViewHeight + YHToolbarHeight;
    if (isHaveNavControler) {
        toolViewY = [UIScreen mainScreen].bounds.size.height - toolViewH - 49;
    } else {
        toolViewY = [UIScreen mainScreen].bounds.size.height - toolViewH;
    }
    self.frame = CGRectMake(toolViewX, toolViewY, toolViewW, toolViewH);
   
    if (!_defaultDate) {
        
        UIView *topLine = [[UIView alloc] init];
        UIView *bottomLine = [[UIView alloc] init];
        topLine.backgroundColor = [UIColor lightGrayColor];
        bottomLine.backgroundColor = [UIColor lightGrayColor];
        
        topLine.frame = CGRectMake(0, (self.bounds.size.height) / 2 + 2, self.bounds.size.width, 1);
        bottomLine.frame = CGRectMake(0, (self.bounds.size.height) / 2 + 38, self.bounds.size.width, 1);
        
        [self addSubview:topLine];
        [self addSubview:bottomLine];
    }
    
    
    
    
}


#pragma mark - 设置工具栏
- (void)setupToolbar {
    
    _toolbar = [self setToolbarStyle];
    [self setToolbarWithPickerViewFrame];
    
    [self addSubview:_toolbar];
}

- (UIToolbar *)setToolbarStyle {
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
    
    UIBarButtonItem *flexiItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    
    toolbar.items = @[leftItem, flexiItem, rightItem];
    
    return toolbar;
}

- (void)setToolbarWithPickerViewFrame {
    
    _toolbar.frame = CGRectMake(0, 0, Screen_Width, YHToolbarHeight);
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    NSInteger component = 0;
    if (_isLevelArray) {
        component = _plistArray.count;
    } else if (_isLevelString) {
        component = 1;
    } else if (_isLevelDic) {
        component = [_levelTwoDic allKeys].count * 2;
    }
    return component;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component  {
    
    NSArray *rowArray = [[NSArray alloc] init];
    if (_isLevelArray) {
        rowArray = _plistArray[component];
    } else if (_isLevelString) {
        rowArray = _plistArray;
    } else if (_isLevelDic) {
        NSInteger pIndex = [pickerView selectedRowInComponent:0];
        NSDictionary *dic = _plistArray[pIndex];
        for (id dicValue in [dic allValues]) {
            if ([dicValue isKindOfClass:[NSArray class]]) {
                if (component % 2 == 1) {
                    rowArray = dicValue;
                } else {
                    rowArray = dicValue;
                }
            }
        }
    }
     
    return rowArray.count;
}



#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component  {
    
    NSString *rowTitle = nil;
    if (_isLevelArray) {
        rowTitle = _plistArray[component][row];
    } else if (_isLevelString) {
        rowTitle = _plistArray[row];
    } else if (_isLevelDic) {
        NSInteger pIndex = [pickerView selectedRowInComponent:0];
        NSDictionary *dic = _plistArray[pIndex];
        if (component % 2 == 0) {
            rowTitle = _dicKeyArray[row][component];
        }
        for (id aa in [dic allValues]) {
            if ([aa isKindOfClass:[NSArray class]] && component % 2 == 1) {
                NSArray *bb = aa;
                if (bb.count > row) {
                    rowTitle = aa[row];
                }
            }
        }
    }
    
    return rowTitle;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (_isLevelDic && component % 2 == 0) {
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    
    if (_isLevelString) {
        _resultString = _plistArray[row];
   
    } else if (_isLevelArray) {
        _resultString = @"";
        if (![self.componentArray containsObject:@(component)]) {
            [self.componentArray addObject:@(component)];
        }
        for (NSInteger i = 0; i < _plistArray.count; i++) {
            if ([self.componentArray containsObject:@(i)]) {
                NSInteger cIndex = [pickerView selectedRowInComponent:i];
                _resultString = [NSString stringWithFormat:@"%@%@", _resultString, _plistArray[i][cIndex]];
            } else {
                _resultString = [NSString stringWithFormat:@"%@%@", _resultString, _plistArray[i][0]];
            }
        }
    
    } else if (_isLevelDic) {
        if (component == 0) {
            _state = _dicKeyArray[row][0];
        } else {
            NSInteger cIndex = [pickerView selectedRowInComponent:0];
            NSDictionary *dicValueDic = _plistArray[cIndex];
            NSArray *dicValueArray = [dicValueDic allValues][0];
            if (dicValueArray.count > row) {
                _city = dicValueArray[row];
            }
        }
    }
}



#pragma mark - 添加 删除
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)remove {
    [self removeFromSuperview];
}


#pragma mark - Toolbar 确定按钮点击,并使用代理回传
- (void)doneClick {
    
    if (_pickerView) {
        
        if (_resultString) {
            
        } else {
            if (_isLevelString) {
                _resultString = [NSString stringWithFormat:@"%@", _plistArray[0]];
            } else if (_isLevelArray) {
                _resultString = @"";
                for (NSInteger i = 0; i < _plistArray.count; i++) {
                    _resultString = [NSString stringWithFormat:@"%@,%@", _resultString, _plistArray[i][0]];
                }
            } else if (_isLevelDic) {
                
                if (_state == nil) {
                    _state = _dicKeyArray[0][0];
                    NSDictionary *dicValueDic = _plistArray[0];
                    _city = [dicValueDic allValues][0][0];
                }
                if (_city == nil) {
                    NSInteger cIndex = [_pickerView selectedRowInComponent:0];
                    NSDictionary *dicValueDic = _plistArray[cIndex];
                    _city = [dicValueDic allValues][0][0];
                }
                _resultString = [NSString stringWithFormat:@"%@%@", _state, _city];
            }
        }
    } else if (_datePicker) {
        _resultString = [NSString stringWithFormat:@"%@", _datePicker.date];
    }
    
    // 调用代理方法
    if ([self.delegate respondsToSelector:@selector(toolbarDonButtonClick:resultString:)]) {
        [self.delegate toolbarDonButtonClick:self resultString:_resultString];
    }
    
    [self remove];
}

#pragma mark - 重写属性setter方法设置颜色
- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    _toolbar.tintColor = tintColor;
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    _toolbar.barTintColor = barTintColor;
}

- (void)setPickerViewBgColor:(UIColor *)pickerViewBgColor {
    
    _pickerView.backgroundColor = pickerViewBgColor;
}

- (void)dealloc {
    NSLog(@"go die");
}

@end
