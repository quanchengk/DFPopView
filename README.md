# DFPopView

#### 导语：
> 重新整合了更灵活的AlertView、DatePickerView、PickerView、SheetView四种样式，适用于对弹窗样式个性化较高的项目
> 加入了removeUntilCall属性，控制弹框是否可以通过点击周围空白区域来隐藏，可根据业务需求灵活定制

![1](https://github.com/quanchengk/DFPopView/blob/master/Resource/1.png)

## AlertView
> 根据原生的UIAlertView，仿制了一套类似的样式，支持样式多变、能适应的需求场景更丰富
* DFAlertStyleSuccess：带成功图标的弹框样式，该样式仅支持跟上标题，不具有详情label
* DFAlertStyleFailure：带失败图标的弹框样式，该样式仅支持跟上标题，不具有详情label
* DFAlertStyleTitleContent：普通的标题+文字样式
* DFAlertStyleInput：带输入框的弹框样式
* DFAlertStyleCustomeIcon：带自定义图标的弹窗，成功、失败仅是该样式的特例

## DatePickerView
仅仅在系统的日期选择器上套了一层壳，用于统一管理弹出样式

## PickerView
可根据数据源来定是多列还是单列，多列的要求是必须按规则结构嵌套，不支持个性化的数据结构

## SheetView
功能类似原生的UIAlertController，布局内容超过屏幕高度3/4时，选择器开放滚动功能

由于我做的项目需要把这些控件的弹出样式、整体风格保持统一，所以有些控件即使改动不大的，也封装在PopKit里面了，各位可根据各自的项目需要抽离需要的控件，控件之间不耦合。
详情请参见demo->DFPopKit
