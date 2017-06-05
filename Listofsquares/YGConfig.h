//
//  YGConfig.h
//  Listofsquares
//
//  Created by TreeWrite on 2017/6/5.
//  Copyright © 2017年 TreeWrite. All rights reserved.
//

#ifndef YGConfig_h
#define YGConfig_h

//导航栏高度
#define yNavigationHeight 64.f
// 屏幕高度
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height
// 屏幕宽度
#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width

#define AdaptSetVCViewFrame(obj)    obj.frame = CGRectMake(CGRectGetMinX(obj.frame), CGRectGetMinY(obj.frame), SCREEN_WIDTH, SCREEN_HEIGHT);

#endif /* YGConfig_h */
