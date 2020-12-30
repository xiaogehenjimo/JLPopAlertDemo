//
//  NSObject+JLCurrentVc.h
//  JLIMProject
//
//  Created by xuqinqiang on 2020/4/11.
//  Copyright © 2020 Qiju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JLCurrentVc)

/**
 获取最顶层的控制器
 不论中间采用了 push->push->present
 还是 present->push->present
 都可以准确的获取到正在显示的控制器。
 */
- (UIViewController *)theTopViewControler;

/// 获取当前控制器
- (UIViewController *)jl_getCurrentVc;
//获取导航控制器
- (UIViewController *)getCurrentNavVC;
@end
