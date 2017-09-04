//
//  ViewController.m
//  DFPopView
//
//  Created by 全程恺 on 2017/9/4.
//  Copyright © 2017年 全程恺. All rights reserved.
//

#import "ViewController.h"
#import "DFAlertView.h"
#import "DFDatePickerView.h"
#import "DFPickerView.h"
#import "DFSheetView.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, DFDatePickerViewDelegate, DFPickerViewDelegate> {
    
    NSArray *_sourceItems;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _sourceItems = @[@{@"AlertView": @[@"普通对话框", @"成功、失败提示", @"单选项、多选项提示", @"排版自定义", @"限制点击区域", @"带输入框的弹框"]},
                     @{@"DatePicker": @[@"普通对话框"]},
                     @{@"PickerView": @[@"单列", @"多列"]},
                     @{@"SheetView": @[@"普通对话框"]}];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _sourceItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[_sourceItems[section] allValues][0] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    NSArray *items = [_sourceItems[indexPath.section] allValues][0];
    cell.textLabel.text = items[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [_sourceItems[section] allKeys][0];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
            
        case 0:
            [self showAlertAt:indexPath.row];
            break;
            
        case 1:
            [self showDatePickerAt];
            break;
            
        case 2:
            [self showPickerAt:indexPath.row];
            break;
            
        case 3:
            [self showSheet];
            break;
            
        default:
            break;
    }
}

#pragma mark - alert view
- (void)showAlertAt:(NSInteger)index {
    
    switch (index) {
            
        case 0:
        {
            DFAlertView *alert = [[DFAlertView alloc] initWithStyle:DFAlertStyleTitleContent title:@"温馨提示" message:@"您当前看到的是普通alertview"];
            DFPopAction *action1 = [DFPopAction actionWithTitle:@"选项1" handler:nil];
            DFPopAction *action2 = [DFPopAction actionWithTitle:@"选项2" handler:nil];
            [alert addAction:action1];
            [alert addAction:action2];
//            [alert addActions:@[action1, action2]];
            [alert show];
        }
            break;
            
        case 1:
        {
            static BOOL isSuccessState = YES;
            
            DFAlertView *alert = [[DFAlertView alloc] initWithStyle:isSuccessState ? DFAlertStyleSuccess : DFAlertStyleFailure
                                                                title:[NSString stringWithFormat:@"您当前看到的是%@alertview, \n下回将展示%@图标的效果", isSuccessState ? @"成功": @"失败", isSuccessState ? @"失败": @"成功"]
                                                              message:nil];
            DFPopAction *action1 = [DFPopAction actionWithTitle:@"选项1" handler:^(DFPopAction *action, DFBasePopView *alertView) {
                isSuccessState = !isSuccessState;
            }];
            DFPopAction *action2 = [DFPopAction actionWithTitle:@"选项2" handler:^(DFPopAction *action, DFBasePopView *alertView) {
                isSuccessState = !isSuccessState;
            }];
            [alert addAction:action1];
            [alert addAction:action2];
//            [alert addActions:@[action1, action2]];
            [alert show];
        }
            break;
            
        case 2:
        {
            static BOOL isChangeLine = NO;
            
            DFAlertView *alert = [[DFAlertView alloc] initWithStyle:DFAlertStyleTitleContent
                                                                title:@"温馨提示"
                                                              message:[NSString stringWithFormat:@"您当前看到的是%@换行的alertview, \n点按钮后，下回将展示%@换行的效果", isChangeLine ? @"": @"不", isChangeLine ? @"不": @""]];
            DFPopAction *action1 = [DFPopAction actionWithTitle:@"选项1" handler:^(DFPopAction *action, DFBasePopView *alertView) {
                isChangeLine = !isChangeLine;
            }];
            [alert addAction:action1];
            
            if (isChangeLine) {
                
                DFPopAction *action2 = [DFPopAction actionWithTitle:@"选项2" handler:^(DFPopAction *action, DFBasePopView *alertView) {
                    isChangeLine = !isChangeLine;
                }];
                DFPopAction *action3 = [DFPopAction actionWithTitle:@"选项3" handler:^(DFPopAction *action, DFBasePopView *alertView) {
                    isChangeLine = !isChangeLine;
                }];
                [alert addActions:@[action2, action3]];
            }
            [alert show];
        }
            break;
            
        case 3:
        {
            DFAlertView *alert = [[DFAlertView alloc] initWithStyle:DFAlertStyleCustomeIcon title:@"自定义alertview，包括自定义提示图标、自定义标题内容、大小、对齐方式，当前的状态没有message内容" message:nil];
            DFPopAction *action = [DFPopAction actionWithTitle:@"我知道了" handler:nil];
            action.titleColor = [UIColor redColor];
            action.font = [UIFont boldSystemFontOfSize:14];
            
            alert.titleLabel.textAlignment = NSTextAlignmentLeft;
            alert.titleLabel.font = [UIFont systemFontOfSize:12];
            alert.iconView.image = [UIImage imageNamed:@"btn_tips"];
            [alert addAction:action];
            [alert show];
        }
            break;
            
        case 4:
        {
            DFAlertView *alert = [[DFAlertView alloc] initWithStyle:DFAlertStyleTitleContent title:@"温馨提示" message:@"点空白位置无效，只能点按钮隐藏弹框"];
            DFPopAction *action = [DFPopAction actionWithTitle:@"我知道了" handler:^(DFPopAction *action, DFBasePopView *alertView) {
                
                [alertView removeCompletion:nil];
            }];
            alert.removeUntilCall = YES;
            [alert addAction:action];
            [alert show];
        }
            break;
            
        case 5:
        {
            DFAlertView *alert = [[DFAlertView alloc] initWithStyle:DFAlertStyleInput title:@"请输入内容" message:@"可输入内容"];
            DFPopAction *action = [DFPopAction actionWithTitle:@"我知道了" handler:nil];
            
            [alert addAction:action];
            [alert show];
        }
            break;
        default:
            break;
    }
}

#pragma mark - date picker view
- (void)showDatePickerAt {
    
    DFDatePickerView *datePicker = [[DFDatePickerView alloc] initWithDefaultDate:[NSDate date] dateModel:UIDatePickerModeDateAndTime delegate:self];
    [datePicker show];
}

- (void)datePickerViewDidSelect:(DFDatePickerView *)pickerView atDate:(NSDate *)selectDate {
    
    NSLog(@"%@", selectDate);
}

#pragma mark - picker view
static NSString *_city;
static NSString *_province;
- (void)showPickerAt:(NSInteger)index {
    
    switch (index) {
        case 0:
        {
            DFPickerView *pickerView = [[DFPickerView alloc] initWithData:@[@"行1", @"行2"] delegate:self];
            pickerView.defaultIndexes = @[@(0)];
            [pickerView show];
        }
            break;
            
        case 1:
        {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
            NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
            
            DFPickerView *cityPicker = [[DFPickerView alloc] initWithData:array delegate:self];
            cityPicker.showKey = @"name";
            cityPicker.dataKey = @"dataArray";
            
            NSMutableArray *defaultIndex = [NSMutableArray array];
            if (_province.length && _city.length) {
                
                for (NSInteger i = 0; i < array.count; i++) {
                    NSDictionary *tempDict = array[i];
                    NSString *temProvince = tempDict[cityPicker.showKey];
                    
                    if ([temProvince isEqualToString:_province]) {
                        
                        NSArray *cityArr = tempDict[cityPicker.dataKey];
                        for (NSInteger j = 0; j < cityArr.count; j++) {
                            NSString *tempCity = cityArr[j];
                            if ([tempCity isEqualToString:_city]) {
                                
                                [defaultIndex addObjectsFromArray:@[@(i), @(j)]];
                                break;
                            }
                        }
                        break;
                    }
                }
            }
            else
                [defaultIndex addObjectsFromArray:@[@(0), @(0)]];
            
            cityPicker.compents = 2;
            cityPicker.defaultIndexes = defaultIndex;
            [cityPicker show];
        }
            break;
        default:
            break;
    }
}

- (void)pickerViewDidSelect:(DFPickerView *)pickerView at:(NSArray *)indexes {
    
    if (pickerView.compents != 1) {
        
        NSDictionary *provinceDic = pickerView.tempObj[[indexes[0] integerValue]];
        
        _province = provinceDic[pickerView.showKey];
        _city = provinceDic[pickerView.dataKey][[indexes[1] integerValue]];
    }
    
    NSLog(@"%@", indexes);
}

#pragma mark - sheet view
- (void)showSheet {
    
    DFSheetView *sheet = [[DFSheetView alloc] initWithTitles:@[@"业务1", @"业务2"] clickIndex:^(NSInteger index) {
        
        NSLog(@"%d", index);
    }];
    
    [sheet show];
}
#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
