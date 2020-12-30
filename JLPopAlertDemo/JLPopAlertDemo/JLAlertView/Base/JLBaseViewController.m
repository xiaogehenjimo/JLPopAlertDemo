//
//  JLBaseViewController.m
//  JLIMProject
//
//  Created by xuqinqiang on 2020/2/21.
//  Copyright © 2020 Qiju. All rights reserved.
//

#import "JLBaseViewController.h"

@interface JLBaseViewController ()

@end

@implementation JLBaseViewController

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.jl_autoChangeStatusBar = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    //self.rt_disableInteractivePop = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.jl_autoChangeStatusBar) {
        if (@available(iOS 13.0, *)) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
        } else {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }
    }
}

- (void)setJl_disableInteractivePop:(BOOL)jl_disableInteractivePop {
    _jl_disableInteractivePop = jl_disableInteractivePop;
//    self.rt_disableInteractivePop = jl_disableInteractivePop;
//    self.rt_navigationController.interactivePopGestureRecognizer.enabled = !jl_disableInteractivePop;
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

/// 双击底部tabbar 子类重写实现
- (void)tabbarDoubleClick {
    
}

@end
