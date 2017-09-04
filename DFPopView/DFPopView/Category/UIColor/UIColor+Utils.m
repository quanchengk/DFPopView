//
//  UIColor+Utils.m
//  ClickNetApp
//
//  Created by mingwei on 10/9/16.
//  Copyright © 2016 xmisp. All rights reserved.
//


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

@implementation UIColor (Utils)

+ (UIColor *)CLIKeyColor {
    
    return HEXCOLOR(kColorBlue);
}

+ (UIColor *)CLIKeyBackgroundColor {
    
    return HEXCOLOR(kColorGrayNormal);
}

+ (UIColor *)CLIKeyButtonBackgroundColor {
    
    return [UIColor CLIKeyColor];
}

+ (UIColor *)CLITextKeyColor {
    
    return [UIColor CLIKeyColor];
}

+ (UIColor *)CLITextDarkColor {
    
    return HEXCOLOR(kColorBlackDark);
}

+ (UIColor *)CLITextNormalColor {
    
    return HEXCOLOR(kColorBlackNormal);
}

+ (UIColor *)CLITextLightColor {

    return HEXCOLOR(kColorBlackLight);
}

+ (UIColor *)CLITextTinyColor {
    
    return HEXCOLOR(kColorBlackTiny);
}

+ (UIColor *)CLILineColor {
    
    return HEXCOLOR(kColorGrayLight);
}

+ (UIColor *)CLIWhiteColor {
    
    return HEXCOLOR(kColorWhite);
}

+ (UIColor *)CLIGreenColor {
    
    
    return HEXCOLOR(kColorGreen);
}

+ (UIColor *)CLIRedColor {
    
    return HEXCOLOR(kColorRed);
}

+ (UIColor *)CLIYellowColor {
    
    return HEXCOLOR(kColorYellow);
}

+ (UIColor *)CLIOrangeColor {
    
    return HEXCOLOR(kColorOrange);
}

+ (UIColor *)CLISectionHeaderColor {
    return HEXCOLOR(kColorGrayDrak);
}

+ (UIColor *)CLICellGrayBGColor {
    return HEXCOLOR(kColorGrayTiny);
}

+ (UIColor *)inputBordorNormalColor {
    return HEXCOLOR(kColorBorderGray);
}

+ (UIColor *)inputBordorHightLightColor {
    return HEXCOLOR(kColorBorderBlue);
}
@end
