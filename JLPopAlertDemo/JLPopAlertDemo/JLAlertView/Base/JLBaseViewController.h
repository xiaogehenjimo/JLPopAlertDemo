//
//  JLBaseViewController.h
//  JLIMProject
//
//  Created by xuqinqiang on 2020/2/21.
//  Copyright © 2020 Qiju. All rights reserved.
//  项目中控制器基类

#import <UIKit/UIKit.h>

@interface JLBaseViewController : UIViewController
/** YES:取消页面右划返回 NO:开启页面右划返回 */
@property (nonatomic, assign) BOOL jl_disableInteractivePop;
/** 页面显示是否自动更改状态栏颜色为黑色 默认YES */
@property (nonatomic, assign) BOOL jl_autoChangeStatusBar;

/// 双击底部tabbar 子类重写实现
- (void)tabbarDoubleClick;

@end
