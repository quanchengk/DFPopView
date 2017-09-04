//
//  DFSheetView.m
//  DFPopView
//
//  Created by 全程恺 on 2017/4/17.
//  Copyright © 2017年 全程恺. All rights reserved.
//

#import "DFSheetView.h"


@implementation DFSheetView

- (instancetype)initWithTitles:(NSArray *)titles clickIndex:(void (^)(NSInteger))clickBlock {
    
    if (self = [super init]) {
        
        _clickBlock = clickBlock;
        
        UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(21, 0, kScreenWidth - 42, MIN(titles.count * 50, kScreenHeight * .75))];
        sc.contentSize = CGSizeMake(sc.frame.size.width, titles.count * 50);
        sc.layer.cornerRadius = self.bottonsView.layer.cornerRadius = kStyleButtonCornerRadius;
        sc.layer.masksToBounds = self.bottonsView.layer.masksToBounds = YES;
        sc.backgroundColor = [UIColor whiteColor];
        
        for (int i = 0; i < titles.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 50 * i, sc.frame.size.width, 50);
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:17];
            [btn setTitleColor:HEXCOLOR(kColorBlackNormal) forState:UIControlStateNormal];
//            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor DFWhiteColor]] forState:UIControlStateNormal];
//            [btn setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(kColorGrayNormal)] forState:UIControlStateHighlighted];
            btn.tag = i;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *lastBtn = [sc.subviews lastObject];
            if (lastBtn && [lastBtn isKindOfClass:[UIButton class]]) {
                
                UIView *line = [UIView new];
                line.backgroundColor = HEXCOLOR(kColorGrayLight);
                [lastBtn addSubview:line];
                
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.right.bottom.equalTo(lastBtn);
                    make.height.mas_equalTo(kStyleLineWidth);
                }];
            }
            [sc addSubview:btn];
        }
        [self.backgroundView addSubview:sc];
        
        self.backgroundView.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, kScreenWidth, sc.frame.size.height + 24 + 49);
        self.backgroundView.backgroundColor = [UIColor clearColor];
        
        DFPopAction *cancelAction = [DFPopAction actionWithTitle:@"取消"
                                                           handler:^(DFPopAction * _Nonnull action, DFBasePopView * _Nonnull alertView) {
                                                               
                                                               [self click:nil];
                                                           }];
        cancelAction.font = [UIFont systemFontOfSize:17];
        cancelAction.titleColor = HEXCOLOR(kColorBlackNormal);
        [self addAction:cancelAction];
        
        self.removeUntilCall = NO;
        self.bottonsView.frame = CGRectMake(sc.frame.origin.x, sc.frame.origin.y + sc.frame.size.height + 12, sc.frame.size.width, 49);
        self.bottonsView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)click:(UIButton *)btn {
    
    if (_clickBlock && btn) {
        
        _clickBlock(btn.tag);
    }
    
    [self removeCompletion:^(BOOL finished) {
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
