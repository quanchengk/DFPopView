//
//  DFSheetView.h
//  DFPopView
//
//  Created by 全程恺 on 2017/4/17.
//  Copyright © 2017年 全程恺. All rights reserved.
//

#import "DFBasePopView.h"

@interface DFSheetView : DFBasePopView {
    
    void (^_clickBlock)(NSInteger);
}

- (instancetype)initWithTitles:(NSArray *)titles clickIndex:(void (^)(NSInteger))clickBlock;

@end
