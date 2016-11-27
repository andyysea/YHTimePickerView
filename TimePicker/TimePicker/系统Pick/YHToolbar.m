//
//  YHToolbar.m
//  TimePicker
//
//  Created by 杨应海 on 2016/11/14.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import "YHToolbar.h"

@implementation YHToolbar
//
//+ (YHToolbar *)yhtoolbar {
//    
//    UIToolbar *toolbar = [UIToolbar alloc] initWithFrame:
//    
//    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelItemClick)];
//    
//    UIBarButtonItem *sureItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureItemClick)];
//    
////    self.items = @[cancelItem, sureItem];
//    
//    return self;
//}
//

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置界面
- (void)setupUI {
//    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelItemClick)];
//    cancelItem.title = @"取消";
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelItemClick)];
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
//    UIBarButtonItem *sureItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(sureItemClick)];
//    sureItem.title = @"确定";
    
    UIBarButtonItem *sureItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(sureItemClick)];
    
    self.items = @[cancelItem, flexibleItem, sureItem];
    
    _cancelItem = cancelItem;
    _sureItem = sureItem;
}

#pragma mark - 点击方法
- (void)cancelItemClick {
    
    if ([self.yhdelegate respondsToSelector:@selector(toolbar:withType:)]) {
        [self.yhdelegate toolbar:self withType:YHToolbarTypeCancel];
    }
}

- (void)sureItemClick {
    if ([self.yhdelegate respondsToSelector:@selector(toolbar:withType:)]) {
        [self.yhdelegate toolbar:self withType:YHToolbarTypeSure];
    }
}

@end
