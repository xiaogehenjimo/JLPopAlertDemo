//
//  JLAlertViewManager.h
//  JLPopAlertDemo
//
//  Created by xuqinqiang on 2020/12/30.
//

#import <Foundation/Foundation.h>

@interface JLAlertViewManager : NSObject
/// 弹窗数组 用于持有自定义弹窗
@property (nonatomic, strong, readonly) NSMutableArray *alertArr;

/// 单例形式调用
+ (instancetype)sharedManager;

@end
