//
//  NSObject+JLCurrentVc.m
//  JLIMProject
//
//  Created by xuqinqiang on 2020/4/11.
//  Copyright © 2020 Qiju. All rights reserved.
//

#import "NSObject+JLCurrentVc.h"

@implementation NSObject (JLCurrentVc)

- (UIViewController *)theTopViewControler {
    //获取根控制器
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;

    UIViewController *parent = rootVC;
    //遍历 如果是presentViewController
    while ((parent = rootVC.presentedViewController) != nil ) {
        rootVC = parent;
    }
    while ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = [(UINavigationController *)rootVC topViewController];
    }
    return rootVC;
}

- (UIViewController *)jl_getCurrentVc {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}
- (UIViewController *)getCurrentNavVC {
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    //获取window的rootViewController
    result = window.rootViewController;
    while (result.presentingViewController) {
        result = result.presentingViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}
@end
