//
//  ViewController.m
//  TestDatePicker
//
//  Created by heyz3a on 16/4/18.
//  Copyright © 2016年 heyz3a. All rights reserved.
//

#import "ViewController.h"
#import "ZHDatePicker.h"

@interface ViewController () <ZHDatePickerDelegate> {
    UILabel *_label;
    
    ZHDatePicker *_picker;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event


- (void)preseedOnButton:(id)sender {
    
    if (nil == _picker) {
        
        ZHDatePicker *picker = [ZHDatePicker presentOnWindow];
        [picker setDelegate:self];
        //        [picker setPickerDisplayMode:ZHDatePickerDisplayModelBeforeCurrent];
        
        
        _picker = picker;
    }
    [_picker present];
    
}

#pragma mark - ZH date Picker Delegate

- (void)didSelectDateWithDate:(NSDate *)date year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    if (nil == date) {
        return;
    }
    
    [_label setText:[NSString stringWithFormat:@"Selected Date: %@-%@-%@", @(year), @(month), @(day)]];
    
    
}

#pragma mark - View

- (void)_createView {
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50.0f, self.view.frame.size.height / 2 - 40.0f, 100.0f, 44.0f)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"Picker" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(preseedOnButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(button.frame) - 50.0f, self.view.frame.size.width, 50.0f)];
    
    [label setText:@"Selected Date "];
    
    [label setTextColor:[UIColor darkTextColor]];
    
    [label setTextAlignment:NSTextAlignmentCenter];
    
    [label setFont:[UIFont systemFontOfSize:16.0f]];
    
    _label = label;
    [self.view addSubview:label];
    
}

@end
