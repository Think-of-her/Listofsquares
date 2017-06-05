//
//  YGProductListCell.h
//  mobile
//
//  Created by TreeWrite on 16/6/29.
//  Copyright © 2016年 1yyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGProductListCell : UITableViewCell

+ (CGFloat)heightForCurrentView;

/**
 *  更新CELL
 *
 *  @param dataDict {@“image”:@"", @"title":@"", @"highlighted":@""}
 */
- (void)updateCellView:(NSDictionary *)dataDict;

/**
 *  cell是否选中
 *
 *  @param isSelected isSelected
 */
- (void)showCellSelected:(BOOL)isSelected;

@end
