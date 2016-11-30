//
//  YHViewController.m
//  TimePicker
//
//  Created by 杨应海 on 2016/11/27.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import "YHViewController.h"
#import "YHPickerView.h"

@interface YHViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) YHPickerView *pickerView;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) NSArray *arrayM;

@end

@implementation YHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrayM = @[@"City",@"一组数组",@"多组数组",@"时间",@"通过数组创建"];

    [self setupUI];
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = self.arrayM[indexPath.row];
    cell.detailTextLabel.text = @"subTitle";
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _indexPath = indexPath;
    [_pickerView remove];
    
//    UITableViewCell * cell=[self.tableView cellForRowAtIndexPath:indexPath];
  
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            _pickerView = [[YHPickerView alloc] initDatePickerWithDate:[NSDate date] datePickerMode:UIDatePickerModeDate isHaveNavControler:YES];
            break;
        case 4:
        { NSArray *array=@[@[@"1",@"小明",@"aa"],@[@"2",@"大黄",@"bb"],@[@"3",@"企鹅",@"cc"]];

            _pickerView = [[YHPickerView alloc] initPickerViewWithArray:array isHaveNavController:YES];
        }
            break;
            
        default:
            break;
    }
    
    
    
    [_pickerView show];
    
}




#pragma mark - 设置界面
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
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
