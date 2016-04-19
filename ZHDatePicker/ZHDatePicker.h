//
//  ZHDatePicker.h
//  TestDatePicker
//
//  Created by heyz3a on 16/4/18.
//  Copyright © 2016年 heyz3a. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZHDatePickerDelegate <NSObject>

@optional

- (void)didSelectDateWithDate:(NSDate *)date year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
@end


typedef enum {
    ZHDatePickerDisplayModeFreeStyle = 0,
    ZHDatePickerDisplayModelBeforeCurrent = 1
} ZHDatePickerDisplayMode;

@interface ZHDatePicker : UIView


@property(nonatomic, weak) id <ZHDatePickerDelegate> delegate;

@property(nonatomic, assign) NSInteger minYear;

@property(nonatomic, assign) NSInteger maxYear;

@property(nonatomic, assign) ZHDatePickerDisplayMode pickerDisplayMode;

+ (instancetype)presentOnWindow;

- (void)present;

- (void)disappear;
@end
