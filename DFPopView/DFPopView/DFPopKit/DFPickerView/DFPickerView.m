//
//  DFPickerView.m
//  DFPopView
//
//  Created by 全程恺 on 2017/4/17.
//  Copyright © 2017年 全程恺. All rights reserved.
//

#import "DFPickerView.h"

@interface DFPickerView () {
    
    
}

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSMutableArray *compentsArr;  //展示的数据，选中某条后插入下一个数据，刷新视图
@end

@implementation DFPickerView

- (UIPickerView *)pickerView {
    
    if (!_pickerView) {
        
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor clearColor];
        _pickerView.showsSelectionIndicator = YES;
    }
    
    return _pickerView;
}

- (NSMutableArray *)compentsArr {
    
    if (!_compentsArr) {
        
        _compentsArr = [NSMutableArray array];
    }
    
    return _compentsArr;
}

- (instancetype)initWithData:(NSArray *)dataArr delegate:(id<DFPickerViewDelegate>)delegate {
    
    if (self = [super init]) {
        
        _delegate = delegate;
        _tempObj = [dataArr copy];
        _dataArr = dataArr;
        _compents = 1;
        [self.compentsArr addObjectsFromArray:@[@(0)]];
        
        NSAssert(dataArr.count, @"没有数据需要展示");
        self.bottonsView.frame = CGRectMake(0, 0, kScreenWidth, 44);
        self.bottonsView.backgroundColor = HEXCOLOR(kColorGrayNormal);
        [self.bottonsView addSubview:self.cancelBtn];
        [self.bottonsView addSubview:self.confirmBtn];
        
        [self.backgroundView addSubview:self.pickerView];
        self.backgroundView.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, kScreenWidth, self.pickerView.frame.size.height + 44);
        self.pickerView.frame = CGRectMake(0, self.bottonsView.frame.origin.y + self.bottonsView.frame.size.height, self.backgroundView.frame.size.width, self.pickerView.frame.size.height);
        
        [self.confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];    }
    
    return self;
}

- (void)confirm {
    
    if ([_delegate respondsToSelector:@selector(pickerViewDidSelect:at:)] && _pickerView) {
        
        [_delegate pickerViewDidSelect:self at:self.compentsArr];
    }
    
    [self removeCompletion:nil];
}

- (void)setDefaultIndexes:(NSArray *)defaultIndexes {
    
    _defaultIndexes = defaultIndexes;
    
    if (_dataArr.count) {
        
        [_defaultIndexes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSAssert([obj isKindOfClass:[NSNumber class]], @"必须传数值对象");
        }];
        [_compentsArr removeAllObjects];
        
        [_compentsArr addObjectsFromArray:_defaultIndexes];
        [self.pickerView reloadAllComponents];
        for (int i = 0; i < _compentsArr.count; i++) {
            
            [self.pickerView selectRow:[_compentsArr[i] integerValue] inComponent:i animated:YES];
        }
    }
}

#pragma mark piackView 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return self.compents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSInteger count = [self getContentAt:component].count;
    
    return count;
}

- (NSArray *)getContentAt:(NSInteger)index {
    
    NSArray *temp = [NSArray arrayWithArray:_dataArr];
    if (self.dataKey.length) {
        
        if (index > 0) {
            
            temp = _dataArr[[self.compentsArr[index - 1] integerValue]][self.dataKey];
        }
    }
    
    return temp;
}

#pragma mark UIPickerViewdelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    
    if (!view) {
        
        view = [UIView new];
        
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = HEXCOLOR(kColorBlackDark);
        label.tag = 1;
        
        UIView *topLine = [pickerView.subviews objectAtIndex:1];
        UIView *bottomLine = [pickerView.subviews objectAtIndex:2];
        topLine.backgroundColor = HEXCOLOR(kColorGrayLight);
        bottomLine.backgroundColor = HEXCOLOR(kColorGrayLight);
        
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(view);
        }];
    }
    
    NSString *title = @"暂无";
    NSArray *contentArr = [self getContentAt:component];
    if (contentArr.count) {
        
        if (self.showKey.length) {
            
            title = contentArr[row];
            if ([title isKindOfClass:[NSDictionary class]]) {
                
                title = ((NSDictionary *)title)[self.showKey];
            }
        }
        else
            title = contentArr[row];
    }
    ((UILabel *)[view viewWithTag:1]).text = title;
    
    return view;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 44;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    for (NSInteger i = component; i < self.compentsArr.count; i++) {
        
        if (i == component) {
            
            [self.compentsArr replaceObjectAtIndex:i withObject:@(row)];
        }
        else {
            
            [self.compentsArr replaceObjectAtIndex:i withObject:@(0)];
            [pickerView reloadComponent:i];
            [pickerView selectRow:[self.compentsArr[i] integerValue] inComponent:i animated:YES];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
