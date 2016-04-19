//
//  ZHDatePicker.m
//  TestDatePicker
//
//  Created by heyz3a on 16/4/18.
//  Copyright © 2016年 heyz3a. All rights reserved.
//

#import "ZHDatePicker.h"

#define kZHDaterPickerDefaultPickerHeight 210.0f

#define  kZHDatePickerDefaultMinimumYear 1960

#define kZHDatePickerDefaultRowHeight 50.0f

@interface ZHDatePicker () <UIPickerViewDelegate, UIPickerViewDataSource> {

    UIView *_container;

    UIPickerView *_pickerView;

    NSArray *_years;

    NSArray *_months;

    NSArray *_days;

    NSInteger _selectedYear;
    NSInteger _selectedMonth;
    NSInteger _selectedDay;
}

@end

@implementation ZHDatePicker

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initilization];
    }
    return self;
}

+ (instancetype)presentOnWindow {
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;

    ZHDatePicker *picker = [[ZHDatePicker alloc] initWithFrame:keywindow.bounds];
    [keywindow addSubview:picker];
    return picker;
}

#pragma mark - Property

- (void)setMinYear:(NSInteger)minYear {
    _minYear = minYear;

    if (_minYear >= _maxYear) {

        //reset default
        _minYear = kZHDatePickerDefaultMinimumYear;
        _maxYear = [self _getCurYear] + 100;
    }

    [_pickerView reloadAllComponents];

}

- (void)setMaxYear:(NSInteger)maxYear {
    _maxYear = maxYear;
    if (_maxYear <= _minYear) {
        //reset default
        _minYear = kZHDatePickerDefaultMinimumYear;
        _maxYear = [self _getCurYear] + 100;
    }
    [_pickerView reloadAllComponents];

}


- (void)setPickerDisplayMode:(ZHDatePickerDisplayMode)pickerDisplayMode {
    _pickerDisplayMode = pickerDisplayMode;

    switch (_pickerDisplayMode) {
        case ZHDatePickerDisplayModeFreeStyle: {

            _minYear = kZHDatePickerDefaultMinimumYear;
            _maxYear = [self _getCurYear] + 100;
        }
            break;
        case ZHDatePickerDisplayModelBeforeCurrent: {
            //strict on display rows

            _maxYear = [self _getCurYear];
            _minYear = kZHDatePickerDefaultMinimumYear;
        }
            break;
        default:
            break;
    }

    [_pickerView reloadAllComponents];
}

#pragma mark - Events

- (void)tappedOnBackground:(UITapGestureRecognizer *)gesture {

    [self disappear];
}

- (void)present {

    __block CGRect frame = _container.frame;
    frame.origin.y = self.frame.size.height;
    [_container setFrame:frame];

    [UIView animateWithDuration:0.3f animations:^{
        [self.layer setOpacity:1.0f];
        frame.origin.y = self.frame.size.height - kZHDaterPickerDefaultPickerHeight;
        [_container setFrame:frame];


    }                completion:^(BOOL finished) {


    }];
}

- (void)disappear {

    [UIView animateWithDuration:0.3f animations:^{

        [self.layer setOpacity:0.0f];
        CGRect frame = _container.frame;
        frame.origin.y = self.frame.size.height;
        [_container setFrame:frame];
    }                completion:^(BOOL finished) {

    }];
}


- (void)_initilization {

    [self setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.1f]];
    [self _createView];
    [self.layer setOpacity:0.0f];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnBackground:)];
    [self addGestureRecognizer:tapGestureRecognizer];


    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate]; // Get necessary date components

    NSInteger curMonth = [components month];
    NSInteger curDay = [components day];
    NSInteger curYear = [components year];


    _minYear = kZHDatePickerDefaultMinimumYear;
    _maxYear = curYear + 100;

    [_pickerView reloadAllComponents];
    [_pickerView selectRow:(curYear - _minYear) inComponent:0 animated:NO];
    [_pickerView selectRow:(curMonth - 1) inComponent:1 animated:NO];
    [_pickerView selectRow:(curDay - 1) inComponent:2 animated:NO];

    _selectedYear = curYear;
    _selectedMonth = curMonth;
    _selectedDay = curDay;

}


- (NSInteger)_getCurMonth {

    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate]; // Get necessary date components

    NSInteger curMonth = [components month];


    return curMonth;
}

- (NSInteger)_getCurDay {

    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate]; // Get necessary date components


    NSInteger curDay = [components day];


    return curDay;
}

- (NSInteger)_getCurYear {

    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate]; // Get necessary date components

    NSInteger curYear = [components year];

    return curYear;
}


#pragma mark - View

- (void)_createView {
    _container = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - kZHDaterPickerDefaultPickerHeight, self.frame.size.width, kZHDaterPickerDefaultPickerHeight)];
    [_container setBackgroundColor:[UIColor whiteColor]];

    [self addSubview:_container];


    _pickerView = [[UIPickerView alloc] initWithFrame:_container.bounds];
    [_pickerView setDelegate:self];
    [_pickerView setDataSource:self];

    [_pickerView setShowsSelectionIndicator:YES];

    [_container addSubview:_pickerView];

}

#pragma mark - Picker Delegate && Datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {


    switch (component) {
        case 0: {
            //year
            return (_maxYear - _minYear) + 1;
        }
            break;
        case 1: {
            //month

            NSInteger yearSelected = [pickerView selectedRowInComponent:0] + _minYear;
            switch (_pickerDisplayMode) {
                case ZHDatePickerDisplayModeFreeStyle: {
                    return 12;
                }
                    break;
                case ZHDatePickerDisplayModelBeforeCurrent: {
                    if ([self _getCurYear] == yearSelected) {
                        return [self _getCurMonth];
                    }
                    return 12;
                }
                    break;
                default:
                    break;
            }
            return 12;

        }
            break;
        case 2: {
            //day


            //get selected year and month;
            NSInteger yearSelected = [pickerView selectedRowInComponent:0] + _minYear;
            NSInteger monthSelected = [pickerView selectedRowInComponent:1] + 1;

            if (_pickerDisplayMode == ZHDatePickerDisplayModelBeforeCurrent) {

                if (yearSelected == [self _getCurYear] && monthSelected == [self _getCurMonth]) {
                    return [self _getCurDay];
                }

            }
            if (monthSelected == 2 && (yearSelected % 4 == 0) && (yearSelected % 100 != 0)) {
                //lap year
                return 29;
            } else if (monthSelected == 2) {
                return 28;
            } else if (monthSelected == 1 || monthSelected == 3 || monthSelected == 5 || monthSelected == 7 || monthSelected == 8 || monthSelected == 10 || monthSelected == 12) {
                return 31;
            } else {
                return 30;
            }
        }
            break;
        default: {
            return 0;
        }
            break;
    }


}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kZHDatePickerDefaultRowHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {

    UILabel *label = (UILabel *) view;
    if (nil == label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _pickerView.frame.size.width / 3, kZHDatePickerDefaultRowHeight)];
    }

    [label setFont:[UIFont systemFontOfSize:14.0f]];
    [label setTextAlignment:NSTextAlignmentCenter];


    NSString *title = @"";
    switch (component) {
        case 0://year
            title = [NSString stringWithFormat:@"%ld年", row + _minYear];
            break;
        case 1://month
            title = [NSString stringWithFormat:@"%ld月", row + 1];
            break;
        case 2://day
            title = [NSString stringWithFormat:@"%ld日", row + 1];
            break;
        default:
            break;
    }
    [label setText:title];
    return label;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0: {
            //year
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];

        }
            break;
        case 1: {
            //month
            [pickerView reloadComponent:2];
        }
            break;
        case 2: {
            //day

        }
            break;

        default:
            break;
    }


    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _selectedYear = [_pickerView selectedRowInComponent:0] + _minYear;
        _selectedMonth = [_pickerView selectedRowInComponent:1] + 1;
        _selectedDay = [_pickerView selectedRowInComponent:2] + 1;

//        NSLog(@"selected year month day :%@ %@ %@", @(_selectedYear), @(_selectedMonth), @(_selectedDay));

        dispatch_async(dispatch_get_main_queue(), ^{
            if (nil != self.delegate && [self.delegate respondsToSelector:@selector(didSelectDateWithDate:year:month:day:)]) {

                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *components = [[NSDateComponents alloc] init];
                [components setDay:_selectedDay];
                [components setMonth:_selectedMonth];
                [components setYear:_selectedYear];
                NSDate *selecteDate = [calendar dateFromComponents:components];

                [self.delegate didSelectDateWithDate:selecteDate year:_selectedYear month:_selectedMonth day:_selectedDay];

            }
        });
    });

}
@end
