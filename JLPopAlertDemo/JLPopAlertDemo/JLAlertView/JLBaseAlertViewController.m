//
//  JLBaseAlertViewController.m
//  JLIMProject
//
//  Created by xuqinqiang on 2020/4/9.
//  Copyright © 2020 Qiju. All rights reserved.
//

#import "JLBaseAlertViewController.h"
#import "JLAlertViewManager.h"
#import "UIViewExt.h"

#define dismissTime 0.25

@interface JLBaseAlertViewController ()
/** 点击空白退出的按钮 */
@property (nonatomic, strong) UIButton *blankBtn;
/** 动画类型 */
@property (nonatomic, assign) JLPopAlertAnimationType animationType;
/** 是否在window */
@property (nonatomic, assign) BOOL inWindow;

@end

@implementation JLBaseAlertViewController

- (instancetype)init {
    if (self = [super init]) {
        _animationTime = 0.5;
        _animationType = JLPopAlertAnimationBottomInBottomOut;
        _contentBgColor = [UIColor colorFromHexRGB:@"000000" andAlpha:.4];
        self.jl_autoChangeStatusBar = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.view.qi_width = SCREENWIDTH;
    self.view.qi_height = SCREENHEIGHT;
    [self contentView];
    self.jl_disableInteractivePop = YES;
}

#pragma mark - public

//显示弹窗 默认动画
- (void)show {
    [self showWithAnimation:_animationType];
}

/// 弹出弹窗
/// @param animation 动画类型
- (void)showWithAnimation:(JLPopAlertAnimationType)animation {
    _animationType = animation;
    //每次弹出都获取最上层的控制器 解决多弹框不能共存的问题
    UIViewController *rootVc = [self theTopViewControler];
    if (!rootVc) {
        rootVc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    }
    __weak typeof(self) weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        [rootVc presentViewController:self animated:NO completion:^{
            [weakSelf jl_alertViewShowWithAnimation];
        }];
    }];
}

/// 在 window 上显示弹窗 默认动画 JLPopAlertAnimationBottomInBottomOut
- (void)showInWindow {
    [self showInWindowWithAnimation:self.animationType];
}

/// 在 window 上显示弹窗
/// @param animation 动画类型
- (void)showInWindowWithAnimation:(JLPopAlertAnimationType)animation {
    _animationType = animation;
    _inWindow = YES;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    dispatch_async(dispatch_get_main_queue(), ^{
        [window endEditing:YES];
        //1.把 self.view 添加到window的窗口上
        [window addSubview:self.view];
        [self jl_alertViewShowWithAnimation];
        //2.再把 self 添加到数组里
        [[JLAlertViewManager sharedManager].alertArr addObject:self];
        NSLog(@"弹窗添加到:%@ 数组个数%ld", window, [JLAlertViewManager sharedManager].alertArr.count);
    });
}

/// 在view上显示
/// @param view 此view一定要是全屏的
/// @param animation 动画类型
- (void)showInView:(UIView *)view
         animation:(JLPopAlertAnimationType)animation {
    if (!view) {return;}
    _animationType = animation;
    _inWindow = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [view endEditing:YES];
        //1.把 self.view 添加到view上
        [view addSubview:self.view];
        [view bringSubviewToFront:self.view];
        [self jl_alertViewShowWithAnimation];
        //2.再把 self 添加到数组里
        [[JLAlertViewManager sharedManager].alertArr addObject:self];
        NSLog(@"弹窗添加到:%@ 数组个数%ld", view, [JLAlertViewManager sharedManager].alertArr.count);
    });
}

//退出弹框
- (void)dismiss {
    [self jl_alertViewDismissWithAnimation:YES];
}

/// 退出弹框
/// @param animation 动画类型
/// @param handleBlock YES:执行消失回调 NO:不执行
- (void)jl_dismissWithAnimation:(JLPopAlertAnimationType)animation
                    handleBlock:(BOOL)handleBlock {
    _animationType = animation;
    [self jl_alertViewDismissWithAnimation:handleBlock];
}

//空白区域点击
- (void)blankBtnPress {
    if (_tapBlankDismiss) {
        [self dismiss];
    }
}

#pragma mark - private

/// 弹窗显示
- (void)jl_alertViewShowWithAnimation {
    CGFloat damping = self.forbiddenFlexible ? 1 : 0.75;//可以禁用弹性效果
    switch (_animationType) {
        case JLPopAlertAnimationBottomInBottomOut: //底部弹出底部消失
        case JLPopAlertAnimationBottomInTopOut: {//底部弹出顶部消失
            self.contentView.qi_top = SCREENHEIGHT;
            [UIView animateWithDuration:self.animationTime delay:0 usingSpringWithDamping:damping initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.contentView.qi_top = 0;
            } completion:^(BOOL finished) {}];
        }
            break;
        case JLPopAlertAnimationTopInTopOut://顶部弹出顶部消失
        case JLPopAlertAnimationTopInBottomOut: {//顶部弹出底部消失
            self.contentView.qi_top = -SCREENHEIGHT;
            [UIView animateWithDuration:self.animationTime delay:.2 usingSpringWithDamping:damping initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.contentView.qi_top = 0;
            } completion:^(BOOL finished) {}];
        }
            break;
        case JLPopAlertAnimationAlpha: {//渐变
            self.contentView.qi_top = 0;
            self.contentView.alpha = 0;
            [UIView animateWithDuration:self.animationTime animations:^{
                self.contentView.alpha = 1;
            }];
        }
            break;
        case JLPopAlertAnimationScal: {//缩放
            self.contentView.qi_top = 0;
            self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity,CGFLOAT_MIN, CGFLOAT_MIN);
             [UIView animateWithDuration:self.animationTime *.6 animations:^{
                 self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
             } completion:^(BOOL finished) {
                 [UIView animateWithDuration:self.animationTime * .4 animations:^{
                     self.contentView.transform = CGAffineTransformIdentity;
                 }];
             }];
        }
            break;
        case JLPopAlertAnimationNone: {//无动画
            self.contentView.qi_top = 0;
        }
            break;
            
        default:
            break;
    }
}

- (void)handleBlock:(BOOL)set {
    if (set) {
        if (self.dismissBlock) {self.dismissBlock();}
    }
}

/// 弹窗消失
- (void)jl_alertViewDismissWithAnimation:(BOOL)handleBlock {
    switch (_animationType) {
        case JLPopAlertAnimationBottomInBottomOut: //底部弹出底部消失
        case JLPopAlertAnimationTopInBottomOut: {//顶部弹出底部消失
            [UIView animateWithDuration:dismissTime animations:^{
                self.contentView.qi_top = SCREENHEIGHT;
            } completion:^(BOOL finished) {
                [self handleBlock:handleBlock];
                [self jl_viewDismiss];
            }];
        }
            break;
        case JLPopAlertAnimationBottomInTopOut: //底部弹出顶部消失
        case JLPopAlertAnimationTopInTopOut: {//顶部弹出顶部消失
            [UIView animateWithDuration:dismissTime animations:^{
                self.contentView.qi_top = -SCREENHEIGHT;
            } completion:^(BOOL finished) {
                [self handleBlock:handleBlock];
                [self jl_viewDismiss];
            }];
        }
            break;
        case JLPopAlertAnimationAlpha: {//渐变
            [UIView animateWithDuration:dismissTime animations:^{
                self.contentView.alpha = 0;
            } completion:^(BOOL finished) {
                [self handleBlock:handleBlock];
                [self jl_viewDismiss];
            }];
        }
            break;
        case JLPopAlertAnimationScal: {//缩放
            [UIView animateWithDuration:dismissTime *.4 animations:^{
                self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:dismissTime * .6 animations:^{
                    self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                } completion:^(BOOL finished) {
                    [self handleBlock:handleBlock];
                    [self jl_viewDismiss];
                }];
            }];
            [UIView animateWithDuration:dismissTime * .8 animations:^{
                self.contentView.alpha = 0;
            }];
        }
            break;
        case JLPopAlertAnimationNone: {//无动画
            self.contentView.hidden = YES;
            [self jl_viewDismiss];
            [self handleBlock:handleBlock];
        }
            break;
            
        default:
            break;
    }
}

//退出弹窗
- (void)jl_viewDismiss {
    if (_inWindow) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        if ([[JLAlertViewManager sharedManager].alertArr containsObject:self]) {
            [[JLAlertViewManager sharedManager].alertArr removeObject:self];
        }
        NSLog(@"弹窗被移除数组个数%ld", [JLAlertViewManager sharedManager].alertArr.count);
    } else {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark - get

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _contentView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_contentView];
     
        _contentView.qi_top = SCREENHEIGHT;
        [_contentView addSubview:self.blankBtn];
        [_blankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return _contentView;
}

- (UIButton *)blankBtn {
    if (!_blankBtn) {
        _blankBtn = [[UIButton alloc] init];
        _blankBtn.backgroundColor = [UIColor clearColor];
        [_blankBtn addTarget:self action:@selector(blankBtnPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _blankBtn;
}

@end
