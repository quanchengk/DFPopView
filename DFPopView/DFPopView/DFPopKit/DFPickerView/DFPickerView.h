//
//  DFPickerView.h
//  DFPopView
//
//  Created by 全程恺 on 2017/4/17.
//  Copyright © 2017年 全程恺. All rights reserved.
//

#import "DFBasePopView.h"

@class DFPickerView;
@protocol DFPickerViewDelegate <NSObject>

//把所有选中的角标按顺序回调，方便外部在数据源查找相应数据
- (void)pickerViewDidSelect:(DFPickerView *)pickerView at:(NSArray *)indexes;

@end

@interface DFPickerView : DFBasePopView <UIPickerViewDataSource,UIPickerViewDelegate> {
    
    NSArray *_dataArr;
    id <DFPickerViewDelegate> _delegate;
}

@property (retain, nonatomic) NSIndexPath *editIndexPath;   //记录下标，用于回调
@property (assign, nonatomic) NSInteger compents;   //默认为1
@property (retain, nonatomic) NSArray *defaultIndexes;
@property (retain, nonatomic) id tempObj;   //model传参用，如果没有特定赋值，默认=dataArr

/*以下两值：不为空=dataArr嵌套字典，需要把key从外部导入；为空=dataArr嵌套字符，直接展示数组
 
 要遵循以下格式
 有值的情况：存在多重嵌套
 dataArr = @[@{showKey: 看到的标题,
               dataKey: 下一栏展示的数据源},
             ...]
 没值的情况：不存在二级三级嵌套，只会有一个compent
 dataArr = @[标题，标题，标题...];
 */
@property (copy, nonatomic) NSString *showKey;
@property (copy, nonatomic) NSString *dataKey;

- (instancetype)initWithData:(NSArray *)dataArr delegate:(id <DFPickerViewDelegate>)delegate;

@end
