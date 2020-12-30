//
//  JLBaseAlertViewController.h
//  JLIMProject
//
//  Created by xuqinqiang on 2020/4/9.
//  Copyright © 2020 Qiju. All rights reserved.
//

#import "JLBaseViewController.h"

#define kMostAlertWidth getAutoSize(280) //大部分弹窗背景的宽

typedef NS_ENUM(NSInteger, JLPopAlertAnimationType) {
    JLPopAlertAnimationBottomInBottomOut = 1,   //底部弹出底部消失
    JLPopAlertAnimationBottomInTopOut,          //底部弹出顶部消失
    JLPopAlertAnimationTopInTopOut,             //顶部弹出顶部消失
    JLPopAlertAnimationTopInBottomOut,          //顶部弹出底部消失
    JLPopAlertAnimationAlpha,                   //渐变
    JLPopAlertAnimationScal,                    //缩放
    JLPopAlertAnimationNone,                    //无动画
};

@interface JLBaseAlertViewController : JLBaseViewController
/**
 1.此视图与控制器视图尺寸一致 用于实现显示 消失动画 默认 透明度0.4黑色
 2.弹窗的内容需要添加在此view上 该视图可以关闭背景响应事件
 */
@property (nonatomic, strong) UIView *contentView;
/// 背景视图的颜色 默认 透明度0.4黑色
@property (nonatomic, strong) UIColor *contentBgColor;
/** 显示动画的时间 默认 0.5s */
@property (nonatomic, assign) CGFloat animationTime;
/** 点击空白处是否退出 默认不退出 */
@property (nonatomic, assign) BOOL tapBlankDismiss;
/** 是否禁用弹性效果 默认不禁用 */
@property (nonatomic, assign) BOOL forbiddenFlexible;
/** 弹窗的tag 用于区分多个弹窗 */
@property (nonatomic, assign) NSInteger alertTag;
/** 消失的回调 */
@property (nonatomic, copy) dispatch_block_t dismissBlock;

//显示弹窗 默认动画 JLPopAlertAnimationBottomInBottomOut
- (void)show;

/// 弹出弹窗
/// @param animation 动画类型
- (void)showWithAnimation:(JLPopAlertAnimationType)animation;

/// 在 window 上显示弹窗 默认动画 JLPopAlertAnimationBottomInBottomOut
- (void)showInWindow;

/// 在 window 上显示弹窗
/// @param animation 动画类型
- (void)showInWindowWithAnimation:(JLPopAlertAnimationType)animation;

/// 在view上显示
/// @param view 此view一定要是全屏的
/// @param animation 动画类型
- (void)showInView:(UIView *)view
         animation:(JLPopAlertAnimationType)animation;

//退出弹框 默认会回调 dismissBlock
- (void)dismiss;

/// 退出弹框
/// @param animation 动画类型
/// @param handleBlock YES:执行消失回调 NO:不执行
- (void)jl_dismissWithAnimation:(JLPopAlertAnimationType)animation
                    handleBlock:(BOOL)handleBlock;

/// 弹窗消失
/// @param handleBlock YES:执行消失回调 NO:不执行消失回调
- (void)jl_alertViewDismissWithAnimation:(BOOL)handleBlock;

@end
