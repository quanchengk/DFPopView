//
//  DFBasePopView.m
//  DFPopView
//
//  Created by 全程恺 on 2017/4/17.
//  Copyright © 2017年 全程恺. All rights reserved.
//

#import "DFBasePopView.h"


@interface DFPopAction ()

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) void (^handler)(DFPopAction *, DFBasePopView *);
@property (retain, nonatomic) UIButton *button; //按钮本身

@end

@implementation DFPopAction

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(DFPopAction *, DFBasePopView *))handler {
    
    DFPopAction *action = [DFPopAction new];
    action.title = title;
    action.handler = handler;
    action.enabled = YES;
    action.titleColor = HEXCOLOR(kColorBlue);
    action.font = [UIFont systemFontOfSize:16];
    action.showSeparatorLine = YES;
    
    return action;
}

- (UIButton *)button {
    
    if (!_button) {
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:self.title forState:UIControlStateNormal];
        [_button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_button setTitleColor:HEXCOLOR(kColorBlackLight) forState:UIControlStateSelected];
//        [_button setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
//        [_button setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(kColorGrayNormal)] forState:UIControlStateHighlighted];
        [_button addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
        _button.titleLabel.font = self.font;
        _button.selected = !self.isEnabled;
        
        if (self.showSeparatorLine) {
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _button.frame.size.width, 1)];
            line.backgroundColor = HEXCOLOR(kColorGrayLight);
            [_button addSubview:line];
            
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(_button);
                make.left.equalTo(_button);
                make.right.equalTo(_button);
                make.height.mas_equalTo(kStyleLineWidth);
            }];
        }
    }
    
    return _button;
}

- (void)clickAction {
    
    DFBasePopView *alertView = [self getTargetClass:[DFBasePopView class] fromObject:self.button];
    
    if (alertView.removeUntilCall) {
        
        //需要手动调用移除方法
        if (self.handler) {
            
            self.handler(self, alertView);
        }
    }
    else {
        
        [alertView removeCompletion:^(BOOL finished) {
            
            if (self.handler) {
                
                self.handler(self, alertView);
            }
        }];
    }
}

- (id)getTargetClass:(Class)className fromObject:(id)obj
{
    UIResponder *next = [obj nextResponder];
    do {
        if ([next isKindOfClass:[className class]]) {
            
            return next;
        }
        next =[next nextResponder];
    }
    while (next != nil);
    
    return nil;
}

@end

@implementation DFBasePopView

- (NSMutableArray *)actions {
    
    if (!_actions) {
        
        _actions = [NSMutableArray array];
    }
    
    return _actions;
}

- (UIButton *)cancelBtn {
    
    if (!_cancelBtn) {
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0, 0, 80, self.styleButtonHeight);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:HEXCOLOR(kColorBlackLight) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _cancelBtn.backgroundColor = [UIColor clearColor];
        
        [_cancelBtn addTarget:self action:@selector(removeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(kScreenWidth - 80, 0, 80, self.styleButtonHeight);
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:HEXCOLOR(kColorBlue) forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _confirmBtn.backgroundColor = [UIColor clearColor];
    }
    
    return _confirmBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)]) {
        
        self.backgroundColor = [HEXCOLOR(kColorBlackDark) colorWithAlphaComponent:.45];
        
        _styleTitleTop = 22;
        _styleIconTop = 22;
        _styleContentLeft = 15;
        _styleContentRight = 15;
        _styleContentSpaceV = 8;
        _styleContentBottom = 22;
        _styleButtonHeight = 45;
        
        UIButton *dimBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [dimBtn addTarget:self action:@selector(removeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dimBtn];
        [self sendSubviewToBack:dimBtn];
        
        [dimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self);
        }];
        
        _backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _backgroundView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.95];
        
        [self addSubview:_backgroundView];
        
        _bottonsView = [UIView new];
        [_backgroundView addSubview:_bottonsView];
        
        if ([self isKindOfClass:NSClassFromString(@"DFAlertView")]) {
            
            _popStyle = DFPopStyleAlertView;
        }
        else if ([self isKindOfClass:NSClassFromString(@"DFSheetView")]) {
            
            _popStyle = DFPopStyleSheetView;
        }
        else if ([self isKindOfClass:NSClassFromString(@"DFPickerView")]) {
            
            _popStyle = DFPopStylePickerView;
        }
        else if ([self isKindOfClass:NSClassFromString(@"DFDatePickerView")]) {
            
            _popStyle = DFPopStyleDatePickerView;
        }
    }
    
    return self;
}

- (void)addAction:(DFPopAction *)action {
    
    [self addActions:@[action]];
}

- (void)addActions:(NSArray *)actions {
    
    for (DFPopAction *action in actions) {
        
        NSAssert([action isKindOfClass:[DFPopAction class]], @"按钮类型错误");
        [self.bottonsView addSubview:action.button];
        [self.actions addObject:action];
    }
    
    //重新布局
    if (self.actions.count <= kMaxButton) {
        
        //左右布局
        [self horizontallyButtons:self.actions];
    }
    else {
        
        //上下布局
        [self verticallyButtons:self.actions];
    }
}

- (void)horizontallyButtons:(NSArray *)actions
{
    if (!actions.count) {
        
        return;
    }
    DFPopAction *firstAction = actions[0];
    [firstAction.button mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(self.bottonsView);
        make.left.equalTo(self.bottonsView);
        make.height.mas_equalTo(self.styleButtonHeight);
    }];
    
    UIButton *lastView = firstAction.button;
    for (int i = 1; i < actions.count; i++) {
        
        DFPopAction *action = actions[i];
        UIButton *view = action.button;
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(lastView.mas_right);
            make.width.top.bottom.height.equalTo(lastView);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = HEXCOLOR(kColorGrayLight);
        [lastView addSubview:line];
        
        [line mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(lastView);
            make.top.equalTo(lastView);
            make.bottom.equalTo(lastView);
            make.width.mas_equalTo(kStyleLineWidth);
        }];
        
        lastView = view;
    }
    
    if (![lastView isEqual:firstAction.button]) {
        
        [firstAction.button mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(lastView);
        }];
    }
    
    [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.bottonsView);
    }];
}

- (void)verticallyButtons:(NSArray *)actions {
    
    if (!actions.count) {
        
        return;
    }
    DFPopAction *firstAction = actions[0];
    [firstAction.button mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self.bottonsView);
        make.height.mas_equalTo(self.styleButtonHeight);
    }];
    
    UIButton *lastView = firstAction.button;
    for (int i = 1; i < actions.count; i++) {
        
        DFPopAction *action = actions[i];
        UIButton *view = action.button;
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(lastView.mas_bottom);
            make.left.right.equalTo(lastView);
            make.height.mas_equalTo(self.styleButtonHeight);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = HEXCOLOR(kColorGrayLight);
        [lastView addSubview:line];
        
        [line mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(lastView);
            make.left.equalTo(lastView);
            make.right.equalTo(lastView);
            make.height.mas_equalTo(kStyleLineWidth);
        }];
        
        lastView = view;
    }
    
    [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.bottonsView);
    }];
}

- (void)show {
    
    [self layoutIfNeeded];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [self.superview endEditing:YES];
    
    [UIView animateWithDuration:.2 animations:^{
        
        self.alpha = 1;
        
        if (_popStyle == DFPopStylePickerView ||
            _popStyle == DFPopStyleSheetView ||
            _popStyle == DFPopStyleDatePickerView) {
            
            CGRect frame = self.backgroundView.frame;
            frame.origin.y = self.backgroundView.frame.origin.y - frame.size.height;
            
            self.backgroundView.frame = frame;
        }
    } completion:^(BOOL finished) {
        
        [self.superview layoutIfNeeded];
    }];
}

- (void)removeAction:(UIButton *)btn {
    
    if ([btn isEqual:_cancelBtn]) {
        
        [self removeCompletion:nil];
    }
    else {
        
        if (!self.removeUntilCall) {
            
            [self removeCompletion:nil];
        }
    }
}

- (void)removeCompletion:(void (^ __nullable)(BOOL finished))completion {
    
    if (_popStyle == DFPopStylePickerView ||
        _popStyle == DFPopStyleSheetView ||
        _popStyle == DFPopStyleDatePickerView) {
        
        [UIView animateWithDuration:.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                             CGRect frame = self.backgroundView.frame;
                             frame.origin.y = kScreenHeight;
                             
                             self.backgroundView.frame = frame;
                             self.alpha = 0;
                         }
                         completion:^(BOOL finished) {
                             
                             [self removeFromSuperview];
                             if (completion) {
                                 
                                 completion(finished);
                             }
                         }];
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
