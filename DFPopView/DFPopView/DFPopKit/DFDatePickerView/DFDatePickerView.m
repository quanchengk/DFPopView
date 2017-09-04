//
//  DFDatePickerView.m
//  DFPopView
//
//  Created by 全程恺 on 2017/4/18.
//  Copyright © 2017年 全程恺. All rights reserved.
//

#import "DFDatePickerView.h"

@interface DFDatePickerView ()

@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation DFDatePickerView

- (UIDatePicker *)datePicker {
    
    if (!_datePicker) {
        
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        [datePicker setTimeZone:[NSTimeZone localTimeZone]];
        
        _datePicker = datePicker;
    }
    
    return _datePicker;
}

- (instancetype)initWithDefaultDate:(NSDate *)date dateModel:(UIDatePickerMode)dateModel delegate:(id<DFDatePickerViewDelegate>)delegate {
    
    if (self = [super init]) {
        
        _delegate = delegate;
        
        self.bottonsView.frame = CGRectMake(0, 0, kScreenWidth, 44);
        self.bottonsView.backgroundColor = HEXCOLOR(kColorGrayNormal);
        [self.bottonsView addSubview:self.cancelBtn];
        [self.bottonsView addSubview:self.confirmBtn];
        
        [self.confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        
        [self.backgroundView addSubview:self.datePicker];
        self.backgroundView.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, kScreenWidth, self.datePicker.frame.size.height + 44);
        self.datePicker.frame = CGRectMake(0, self.bottonsView.frame.origin.y + self.bottonsView.frame.size.height, self.backgroundView.frame.size.width, self.datePicker.frame.size.height);
        
        if (date) {
            
            [self.datePicker setDate:date animated:YES];
        }
        [self.datePicker setDatePickerMode:dateModel];
    }
    
    return self;
}

- (void)confirm {
    
    if ([_delegate respondsToSelector:@selector(datePickerViewDidSelect:atDate:)] && _datePicker) {
        
        [_delegate datePickerViewDidSelect:self atDate:_datePicker.date];
    }
    
    [self removeCompletion:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
