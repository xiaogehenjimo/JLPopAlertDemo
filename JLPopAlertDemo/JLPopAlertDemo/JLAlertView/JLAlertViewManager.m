//
//  JLAlertViewManager.m
//  JLPopAlertDemo
//
//  Created by xuqinqiang on 2020/12/30.
//

#import "JLAlertViewManager.h"

@implementation JLAlertViewManager

/// 单例形式调用
+ (instancetype)sharedManager {
    static JLAlertViewManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JLAlertViewManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _alertArr = [NSMutableArray array];
    }
    return self;
}

@end
