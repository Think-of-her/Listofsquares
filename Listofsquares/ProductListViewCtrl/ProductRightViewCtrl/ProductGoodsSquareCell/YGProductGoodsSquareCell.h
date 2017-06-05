//
//  YGProductGoodsSquareCell.h
//  mobile
//
//  Created by TreeWrite on 16/6/29.
//  Copyright © 2016年 1yyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGProductGoodsSquareCell : UICollectionViewCell


+ (CGSize)heightForCurrentView;

/**
 *  更新cell控件
 *
 *  @param dataDict 传入的参数
 */
- (void)updateCellViewWithData:(NSDictionary *)dataDict;

@end
