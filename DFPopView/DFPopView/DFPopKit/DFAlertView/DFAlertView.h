//
//  DFAlertView.h
//  DFPopView
//
//  Created by 全程恺 on 16/12/9.
//  Copyright © 2016年 全程恺. All rights reserved.
//

#import "DFBasePopView.h"

#define kBackgroundViewSpaceLeft 53

typedef enum {
    
    DFAlertStyleSuccess,      //居中警告，成功
    DFAlertStyleFailure,      //居中警告，失败
    DFAlertStyleTitleContent, //居中警告，带黑色标题和内容，居中
//    DFStoreStyleAlertKeyContent,   //居中警告，带黑色标题左对齐，和红色内容居中
    DFAlertStyleInput,        //居中警告，带黑色标题和输入框
    DFAlertStyleCustomeIcon,        //居中警告，可自定义弹窗图片
} DFAlertStyle;

@interface DFAlertView : DFBasePopView

@property (nonatomic, strong, readonly) UIImageView  * _Nullable iconView;   //只有警告类型为CustomeIcon，这个属性才有值，可通过iconview.image = ...直接修改图片
@property (nonatomic, strong, nonnull) UILabel      *messageLabel;
@property (nonatomic, strong, nonnull) UILabel      *titleLabel;
//输入框，只有DFStoreStyleAlertInput这种样式才有值
@property (retain, nonatomic, nullable) UITextView *inputView;

/*自定义弹框样式
 *  参数解释:
 *  style:  提示样式
 *  title:  标题（加粗字体）
 *  tip:    提示信息，可不传
 *  示例：
 
 DFAlertView *alert = [[DFAlertView alloc] initWithStyle:DFAlertStyleTitleContent title:@"" message:@"确认取消订单？"];
 DFPopAction *action1 = [DFPopAction actionWithTitle:@"取消" handler:^(DFPopAction *action, DFBasePopView *lertView) {
 
 }];
 DFPopAction *action2 = [DFPopAction actionWithTitle:@"确定" handler:^(DFPopAction *action, DFBasePopView *lertView) {

 }];
 
 [alert addAction:action1];
 [alert addAction:action2];
 
 [alert show];
 */
- (instancetype _Nonnull)initWithStyle:(DFAlertStyle)style title:(NSString * _Nullable)title message:(NSString * _Nullable)tip;

@end
