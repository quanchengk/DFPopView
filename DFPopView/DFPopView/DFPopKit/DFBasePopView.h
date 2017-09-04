//
//  DFBasePopView.h
//  DFPopView
//
//  Created by 全程恺 on 2017/4/17.
//  Copyright © 2017年 全程恺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

#define kColorBlackDark   0x000000    //深黑
#define kColorBlackNormal 0x333333  //正常黑
#define kColorBlackLight  0x666666   //浅黑
#define kColorBlackTiny   0x999999   //更浅黑
#define kColorGrayNormal  0xf3f4f6   //正常灰
#define kColorGrayLight   0xe2e2e2   //浅灰（线的颜色）
#define kColorWhite       0xffffff    //白色
#define kColorGreen       0x0db43d    //绿色
#define kColorRed         0xd20000    //红色
#define kColorYellow      0xfe8600    //橙黄
#define kColorOrange      0xFF4E00    //橙色（用在待确认的价格上）
#define kColorBlue        0x0366c1    //点击蓝
#define kColorGrayDrak    0xf0f0f6    //深灰
#define kColorGrayTiny    0xf9f9fa      //浅灰，cell的背景

#define kColorBorderGray    0xb8b8b8    //文本框边框灰色
#define kColorBorderBlue    0x0366c1    //文本框边框蓝色

#define kStyleButtonCornerRadius 4
#define kStyleLineWidth .5

//屏幕高度
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

//屏幕宽度
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)

// 十六进制颜色设置
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//弹框操作按钮的同行个数，按钮数在个数内就展示在同一行，在个数外则垂直展示
#define kMaxButton 2

typedef enum {
    
    DFPopStyleAlertView,      //警告框
    DFPopStyleSheetView,   //底部表单选择器
    DFPopStylePickerView,  //
    DFPopStyleDatePickerView,  //
} DFPopStyle;

@class DFBasePopView;
@interface DFPopAction : NSObject

+ (instancetype _Nonnull)actionWithTitle:(NSString * _Nonnull)title handler:(void (^ _Nullable)(DFPopAction * _Nonnull action, DFBasePopView * _Nonnull alertView))handler;

@property (retain, nonatomic, nullable) UIFont *font; //默认14
@property (retain, nonatomic, nullable) UIColor *titleColor;  //默认主题色
@property (assign, nonatomic) BOOL showSeparatorLine;  //默认显示分割线
@property (assign, nonatomic, getter=isEnabled) BOOL enabled;         //默认yes
@end

@interface DFBasePopView : UIView {
    
    DFPopStyle _popStyle;
}

@property (nonatomic, assign) CGFloat styleTitleTop;    //标题距离顶部，默认22
@property (nonatomic, assign) CGFloat styleIconTop;    //图标距离顶部，默认22
@property (nonatomic, assign) CGFloat styleContentLeft; //文本距离背景左边距，默认15
@property (nonatomic, assign) CGFloat styleContentRight;    //文本距离背景右边距，默认15
@property (nonatomic, assign) CGFloat styleContentSpaceV;   //文本间垂直距离，默认8
@property (nonatomic, assign) CGFloat styleContentBottom;   //文本距离背景底部间距，默认22
@property (nonatomic, assign) CGFloat styleButtonHeight;    //底部按钮的高度，默认45

@property (nonatomic, strong) UIView        * _Nonnull backgroundView;
@property (nonatomic, strong) UIView        * _Nonnull bottonsView;
@property (nonatomic, strong) UIButton      * _Nullable cancelBtn;
@property (nonatomic, strong) UIButton      * _Nullable confirmBtn;
@property (nonatomic, retain) NSMutableArray * _Nullable actions;
//是否要手动移除，默认是否
@property (assign, nonatomic) BOOL removeUntilCall;

//增加点击行为
- (void)addAction:(DFPopAction * _Nonnull)action;
//可以一个或多个，建议有按钮，否则无法回收弹框
- (void)addActions:(NSArray * _Nonnull)actions;

- (void)show;

- (void)removeCompletion:(void (^ __nullable)(BOOL finished))completion;

@end
