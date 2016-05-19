# ZHDatePicker

[![CI Status](http://img.shields.io/travis/zhhlmr/ZHDatePicker.svg?style=flat)](https://travis-ci.org/zhhlmr/ZHDatePicker)
[![Version](https://img.shields.io/cocoapods/v/ZHDatePicker.svg?style=flat)](http://cocoapods.org/pods/ZHDatePicker)
[![License](https://img.shields.io/cocoapods/l/ZHDatePicker.svg?style=flat)](http://cocoapods.org/pods/ZHDatePicker)
[![Platform](https://img.shields.io/cocoapods/p/ZHDatePicker.svg?style=flat)](http://cocoapods.org/pods/ZHDatePicker)


A simple custom iOS date picker.


![Alt text](/screen.png)


#### Animation

Simply slide up from the bottom

#### Delegate

Whenever user select on year/month/day , will info delegate with all new value.

```sh
@protocol ZHDatePickerDelegate <NSObject>

@optional

- (void)didSelectDateWithDate:(NSDate *)date year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
@end

```


#### Properties


```sh
@property(nonatomic, assign) NSInteger minYear;//default : 1960

@property(nonatomic, assign) NSInteger maxYear;//default : 100 + today's year

```


#### Display Mode:

```sh
typedef enum {
    ZHDatePickerDisplayModeFreeStyle = 0,
    ZHDatePickerDisplayModelBeforeCurrent = 1
} ZHDatePickerDisplayMode;
```

- ZHDatePickerDisplayModeFreeStyle
> Select date whatever you want from default setting (1960 - 100 years after current year)
- ZHDatePickerDisplayModelBeforeCurrent
> Set the maximun Date to today's date , and limit user's selection from 1960 - current year

#### TODO

- Slide position
- Time selection
- Background and Text Color




## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ZHDatePicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZHDatePicker"
```

## Author

[zhhlmr](http://github.com/zhhlmr), zhouhan199132@gmail.com

## License

ZHDatePicker is available under the MIT license. See the LICENSE file for more info.
