//
//  YGProductGoodsListViewCtrl.h
//  MeiTuan
//
//  Created by TreeWrite on 16/6/28.
//  Copyright © 2016年 TreeWrite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGProductGoodsListViewCtrl : UIViewController

/**
 *  切换列表或九宫格
 *
 *  @param styleInt 0列表   1九宫格
 */
- (void)updateViewStyle:(NSInteger)styleInt;

/**
 *  网络请求
 *
 *  @param typeID 分类ID
 */
- (void)requestListWithType:(NSInteger)typeID;

/**
 *  网络请求
 *
 *  @param typeID 分类ID
 *  @param sortID  小的分类ID
 */
- (void)requestListWithType:(NSInteger)typeID sortWith:(NSInteger)sortID;

@end
