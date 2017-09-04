//
//  UIFont+Utils.m
//  ClickNetApp
//
//  Created by 全程恺 on 16/11/29.
//  Copyright © 2016年 xmisp. All rights reserved.
//

#import "UIFont+Utils.h"

@implementation UIFont (Utils)

//用于提示页、如身份认证页

+ (UIFont *)CLIFontSize21 {
    
    return [UIFont systemFontOfSize:21];
}

//用于Nav提示字、资质类型选择、新闻大标题
+ (UIFont *)CLIFontSize19 {
    
    return [UIFont systemFontOfSize:19];
}

//用于btn字体、大价格
+ (UIFont *)CLIFontSize18 {
    
    return [UIFont systemFontOfSize:18];
}

//用于空白页、popup提示字、个人页的login字、右上角
+ (UIFont *)CLIFontSize17 {
    
    return [UIFont systemFontOfSize:17];
}

//用于业务流水、订单类标题、新闻标题、查询域名结果名称
+ (UIFont *)CLIFontSize16 {
    
    return [UIFont systemFontOfSize:16];
}

//用于列表标题、内容、login、状态、部分小价格、内容（App常用文字）
+ (UIFont *)CLIFontSize15 {
    
    return [UIFont systemFontOfSize:15];
}


/**
 用于Icon字体、域名页状态、提示

 @return CLIFontSize14
 */
+ (UIFont *)CLIFontSize14 {
    
    return [UIFont systemFontOfSize:14];
}


/**
 用于备注、tab文字

 @return CLIFontSize13
 */
+ (UIFont *)CLIFontSize13 {
    
    return [UIFont systemFontOfSize:13];
}

/**
 用于时间
 
 @return CLIFontSize12
 */
+ (UIFont *)CLIFontSize12 {
    
    return [UIFont systemFontOfSize:12];
}

@end
