//
//  YHToolbar.h
//  TimePicker
//
//  Created by 杨应海 on 2016/11/14.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHToolbar;

typedef NS_ENUM(NSUInteger, YHToolbarType) {
    YHToolbarTypeCancel,
    YHToolbarTypeSure
};


@protocol YHToolbarDelegate <NSObject>

- (void)toolbar:(YHToolbar *)toolbar withType:(YHToolbarType)type;

@end



@interface YHToolbar : UIToolbar

@property (nonatomic, weak) UIBarButtonItem *cancelItem;
@property (nonatomic, weak) UIBarButtonItem *sureItem;


@property (nonatomic, weak) id<YHToolbarDelegate> yhdelegate;

@end
