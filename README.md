# ZHDatePicker

An simple custom iOS date picker.


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
