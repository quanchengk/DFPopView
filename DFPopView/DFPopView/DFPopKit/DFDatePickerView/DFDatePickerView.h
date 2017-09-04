//
//  DFDatePickerView.h
//  DFPopView
//
//  Created by 全程恺 on 2017/4/18.
//  Copyright © 2017年 全程恺. All rights reserved.
//

#import "DFBasePopView.h"

@class DFDatePickerView;
@protocol DFDatePickerViewDelegate <NSObject>

//把所有选中的角标按顺序回调，方便外部在数据源查找相应数据
- (void)datePickerViewDidSelect:(DFDatePickerView *)pickerView atDate:(NSDate *)selectDate;

@end

@interface DFDatePickerView : DFBasePopView {
    
    id <DFDatePickerViewDelegate> _delegate;
}

- (instancetype)initWithDefaultDate:(NSDate *)date dateModel:(UIDatePickerMode)dateModel delegate:(id <DFDatePickerViewDelegate>)delegate;

@end
