//
//  UIColor+Utils.h
//  ClickNetApp
//
//  Created by mingwei on 10/9/16.
//  Copyright © 2016 xmisp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)

+ (UIColor *)CLIKeyColor; // 主色
+ (UIColor *)CLIKeyBackgroundColor; // 主背景色
+ (UIColor *)CLIKeyButtonBackgroundColor; // 按钮背景颜色
+ (UIColor *)CLITextKeyColor; // 文字主颜色
+ (UIColor *)CLITextDarkColor; // 文字深黑颜色 (颜色较浅黑深)
+ (UIColor *)CLITextNormalColor; // 文字正常颜色
+ (UIColor *)CLITextLightColor; // 文字浅灰颜色
+ (UIColor *)CLITextTinyColor;  //文字淡色
+ (UIColor *)CLILineColor; // 分割线颜色
+ (UIColor *)CLIWhiteColor; // 白色
+ (UIColor *)CLIGreenColor; //绿色
+ (UIColor *)CLIRedColor;   //红色
+ (UIColor *)CLIYellowColor;    //黄色
+ (UIColor *)CLIOrangeColor;    //橙色
+ (UIColor *)CLISectionHeaderColor;//深灰
+ (UIColor *)CLICellGrayBGColor;//深灰

//inputcell用到的颜色
+ (UIColor *)inputBordorNormalColor;    //普通边框
+ (UIColor *)inputBordorHightLightColor;    //高亮边框

@end
