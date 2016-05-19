//
//  ZHDatePickerViewController.m
//  ZHDatePicker
//
//  Created by zhhlmr on 05/19/2016.
//  Copyright (c) 2016 zhhlmr. All rights reserved.
//

#import "ZHDatePickerViewController.h"
#import "ZHDatePicker.h"

@interface ZHDatePickerViewController ()<ZHDatePickerDelegate>

@property(nonatomic,strong) UILabel *label;

@property(nonatomic,strong) UIButton* button;

@property(nonatomic,strong) ZHDatePicker *picker;
@end

@implementation ZHDatePickerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _createView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter

-(ZHDatePicker *)picker {
    
    if (nil == _picker) {
        
        ZHDatePicker *picker = [ZHDatePicker presentOnWindow];
        [picker setDelegate:self];
        _picker = picker;
    }
    return _picker;
}

-(UIButton *)button {
    if(nil==_button) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50.0f, self.view.frame.size.height / 2 - 40.0f, 100.0f, 44.0f)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:@"Picker" forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(preseedOnButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _button = button;
        
    }
    return _button;
}
-(UILabel *)label {
    if(nil==_label) {
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.button.frame) - 50.0f, self.view.frame.size.width, 50.0f)];
        
        [label setText:@"Selected Date "];
        
        [label setTextColor:[UIColor darkTextColor]];
        
        [label setTextAlignment:NSTextAlignmentCenter];
        
        [label setFont:[UIFont systemFontOfSize:16.0f]];
        
        _label = label;
        
    }
    return _label;
}


#pragma mark - ZH date Picker Delegate

- (void)didSelectDateWithDate:(NSDate *)date year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    if (nil == date) {
        return;
    }
    
    [self.label setText:[NSString stringWithFormat:@"Selected Date: %@-%@-%@", @(year), @(month), @(day)]];
    
    
}

#pragma mark - Button Events

-(void)preseedOnButton:(id)sender {
    
    [self.picker present];
    
}

#pragma mark - Create View

-(void)_createView {
    [self.view addSubview:self.button];
    
    [self.view addSubview:self.label];
    
}

@end
