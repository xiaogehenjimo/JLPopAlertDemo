//
//  UIColor+change.h
//  JLPopAlertDemo
//
//  Created by xuqinqiang on 2020/12/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (change)

/*
 通过16进制计算颜色
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString andAlpha:(CGFloat)alpha;

/// UIColor转#ffffff格式的字符串
+ (NSString *)HexStringWithColor:(UIColor *)color;
+ (NSString *)HexStringWithColor:(UIColor *)color HasAlpha:(BOOL)hasAlpha;

@end

NS_ASSUME_NONNULL_END
