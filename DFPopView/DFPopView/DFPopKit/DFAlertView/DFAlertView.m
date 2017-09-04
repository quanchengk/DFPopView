//
//  DFAlertView.m
//  DFPopView
//
//  Created by 全程恺 on 16/12/9.
//  Copyright © 2016年 全程恺. All rights reserved.
//

#import "DFAlertView.h"

#define kMaxInputCount 100  //最多允许输入的文字内容
@interface DFAlertView () <UITextViewDelegate> {
    
}

@property (nonatomic, strong) UILabel *countLabel;  //字数统计
@property (nonatomic, strong) UIImageView   *iconView;
@property (nonatomic, assign) DFAlertStyle style;

@end

@implementation DFAlertView

- (instancetype)initWithStyle:(DFAlertStyle)style title:(NSString *)title message:(NSString *)tip {
    
    if (self = [super initWithFrame:CGRectZero]) {
        
        _style = style;
        
        CGFloat width = kScreenWidth - kBackgroundViewSpaceLeft * 2;
        
        self.backgroundView.frame = CGRectMake(kBackgroundViewSpaceLeft, 0, width, 0);
        self.backgroundView.layer.cornerRadius = 12;
        self.backgroundView.layer.masksToBounds = YES;
        
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(width);
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = HEXCOLOR(kColorBlackDark);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.preferredMaxLayoutWidth = width - self.styleContentLeft - self.styleContentRight;
        _titleLabel.text = title;
        [self.backgroundView addSubview:_titleLabel];
        
        if (style == DFAlertStyleSuccess ||
            style == DFAlertStyleFailure ||
            style == DFAlertStyleCustomeIcon) {
            
            if (style == DFAlertStyleSuccess ||
                style == DFAlertStyleFailure) {
                
                _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:style == DFAlertStyleSuccess ? @"icon_popup_success" : @"icon_popup_fail"]];
                
                _iconView.center = CGPointMake(width / 2, 0);
            }
            else
                _iconView = [UIImageView new];
            
            CGRect frame = _iconView.frame;
            frame.origin = CGPointMake(frame.origin.x, self.styleIconTop);
            _iconView.frame = frame;
            [self.backgroundView addSubview:_iconView];
            
            [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(_iconView.mas_bottom).offset(self.styleContentSpaceV);
                make.left.equalTo(self.backgroundView).offset(self.styleContentLeft);
                make.right.equalTo(self.backgroundView).offset(-self.styleContentRight);
            }];
            
            [self.bottonsView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(_titleLabel.mas_bottom).offset(self.styleContentBottom);
                make.left.bottom.right.equalTo(self.backgroundView);
            }];
        }
        else {
            
            [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.backgroundView).offset(self.styleTitleTop);
                make.left.equalTo(self.backgroundView).offset(self.styleContentLeft);
                make.right.equalTo(self.backgroundView).offset(-self.styleContentRight);
            }];
            
            if (style == DFAlertStyleInput) {
                
                _inputView = [[UITextView alloc] initWithFrame:CGRectMake(self.styleContentLeft, 0, _titleLabel.preferredMaxLayoutWidth, 33)];
                _inputView.layer.cornerRadius = 4.f;
                _inputView.layer.masksToBounds = YES;
                _inputView.layer.borderColor = HEXCOLOR(kColorGrayLight).CGColor;
                _inputView.layer.borderWidth = kStyleLineWidth;
                _inputView.textColor = HEXCOLOR(kColorBlackNormal);
                _inputView.backgroundColor = [UIColor whiteColor];
                _inputView.font = [UIFont systemFontOfSize:14];
                _inputView.delegate = self;
                [self.backgroundView addSubview:_inputView];
                
                _countLabel = [UILabel new];
                _countLabel.font = [UIFont systemFontOfSize:13];
                _countLabel.textColor = HEXCOLOR(kColorBlackLight);
                [self.backgroundView addSubview:_countLabel];
                
                [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.size.mas_equalTo(_inputView.frame.size);
                    make.top.equalTo(_titleLabel.mas_bottom).offset(self.styleContentSpaceV);
                    make.centerX.equalTo(self.backgroundView);
                }];
                
                [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(_inputView.mas_bottom).offset(self.styleContentSpaceV);
                    make.right.equalTo(_inputView);
                }];
                
                [self.bottonsView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(_countLabel.mas_bottom).offset(self.styleContentSpaceV);
                    make.left.bottom.right.equalTo(self.backgroundView);
                }];
                
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
            }
            else if (tip.length) {
                
                _messageLabel = [UILabel new];
                _messageLabel.textColor = HEXCOLOR(kColorBlackDark);
                _messageLabel.font = [UIFont systemFontOfSize:15];
                _messageLabel.textAlignment = NSTextAlignmentCenter;
                _messageLabel.numberOfLines = 0;
                _messageLabel.text = tip;
                _messageLabel.preferredMaxLayoutWidth = _titleLabel.preferredMaxLayoutWidth;
                [self.backgroundView addSubview:_messageLabel];
                
                [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(_titleLabel.mas_bottom).offset(self.styleContentSpaceV);
                    make.left.equalTo(self.backgroundView).offset(self.styleContentLeft);
                    make.right.equalTo(self.backgroundView).offset(- self.styleContentRight);
                }];
                
                [self.bottonsView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(_messageLabel.mas_bottom).offset(self.styleContentBottom);
                    make.left.bottom.right.equalTo(self.backgroundView);
                }];
            }
            else {
                
                [self.bottonsView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(_titleLabel.mas_bottom).offset(self.styleContentBottom);
                    make.left.bottom.right.equalTo(self.backgroundView);
                }];
            }
        }
        
        self.alpha = 0;
    }
    
    return self;
}

- (void)show {
    
    if (_style == DFAlertStyleCustomeIcon) {
        
        UIImage *customerIcon = _iconView.image;
        NSAssert(customerIcon, @"当前类型为DFAlertStyleCustomeIcon，但是代码没有传入警告框图片");
        
        CGFloat width = self.backgroundView.frame.size.width - 2 * 52;
        
        CGRect iconFrame = _iconView.frame;
        if (customerIcon.size.width >= width) {
            
            CGFloat rate = width / customerIcon.size.width;
            iconFrame.size = CGSizeMake(width, customerIcon.size.height * rate);
        }
        else
            iconFrame.size = customerIcon.size;
        
        _iconView.frame = iconFrame;
        _iconView.center = CGPointMake(self.backgroundView.frame.size.width / 2, _iconView.center.y);
    }
    
    [super show];
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.5;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95f, 0.95f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.backgroundView.layer addAnimation:popAnimation forKey:nil];
    self.backgroundView.transform = CGAffineTransformScale(self.transform,1,1);
    
    if (_style == DFAlertStyleInput) {
        
        _countLabel.text = [NSString stringWithFormat:@"%lu/%d", (unsigned long)_inputView.text.length, kMaxInputCount];
        [self resizeInputFrame:_inputView.text];
        [_inputView becomeFirstResponder];
    }
}

- (void)removeCompletion:(void (^ __nullable)(BOOL finished))completion {
    
    [UIView animateWithDuration:.2 animations:^{
        
        self.backgroundView.transform = CGAffineTransformScale(self.transform, .1, .1);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        if (completion) {
            
            completion(finished);
        }
    }];
//    _showWindow.hidden = YES;
//    _showWindow = nil;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = frame.origin.y;
    self.frame = CGRectMake(0, 0, self.frame.size.width, height);
    
    [UIView animateWithDuration:.2 animations:^{
        
        if (_style == DFAlertStyleInput) {
            
            [self resizeInputFrame:_inputView.text];
        }
        else
            [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        if (_style == DFAlertStyleInput) {
            
            [self resizeInputFrame:_inputView.text];
        }
    }];
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification
{
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = frame.origin.y;
    self.frame = CGRectMake(0, 0, self.frame.size.width, height);
    
    [UIView animateWithDuration:.2 animations:^{
        
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        NSLog(@"%f", _inputView.frame.size.height);
    }];
}

#pragma mark - textview delegate
- (void)textViewDidChange:(UITextView *)textView {
    
    _countLabel.text = [NSString stringWithFormat:@"%lu/%d", (unsigned long)textView.text.length, kMaxInputCount];
    [self resizeInputFrame:textView.text];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    [self resizeInputFrame:textView.text];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSString *str = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([textView.text substringWithRange:range].length) {
        
        //删除
        return YES;
    }
    
    //添加
    if (str.length <= kMaxInputCount) {
        
        return YES;
    }
    
    NSLog(@"最多只允许输入%d个字符", kMaxInputCount);
    
    return NO;
}

- (void)resizeInputFrame:(NSString *)text {
    
    static CGFloat maxHeight = 72.f;
    CGRect frame = _inputView.frame;
    
    //计算滚动内容的宽高
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGFloat height = [_inputView sizeThatFits:constraintSize].height;
    if (height != frame.size.height) {
        
        if (height >= maxHeight)
        {
            height = maxHeight;
            _inputView.scrollEnabled = YES;   // 允许滚动
        }
        else
        {
            _inputView.scrollEnabled = NO;    // 不允许滚动
        }
        
        CGRect frame = _inputView.frame;
        frame.size = CGSizeMake(_titleLabel.preferredMaxLayoutWidth, height);
        _inputView.frame = frame;
        
        [_inputView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(frame.size);
        }];
        
        [_inputView layoutIfNeeded];
        [self layoutIfNeeded];
    }
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
