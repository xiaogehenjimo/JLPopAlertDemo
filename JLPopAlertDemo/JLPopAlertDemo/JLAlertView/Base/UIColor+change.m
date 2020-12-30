//
//  UIColor+change.m
//  JLPopAlertDemo
//
//  Created by xuqinqiang on 2020/12/30.
//

#import "UIColor+change.h"

@implementation UIColor (change)

/*
 通过16进制计算颜色
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString {
    return [self colorFromHexRGB:inColorString andAlpha:1.0];
}

+ (UIColor *)colorFromHexRGB:(NSString *)colorStr andAlpha:(CGFloat)alpha {
    NSString *inColorString = [colorStr stringByReplacingOccurrencesOfString:@"#" withString:@""];
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString) {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:alpha];
    return result;
}

///UIColor转#ffffff格式的字符串
+ (NSString *)HexStringWithColor:(UIColor *)color {
    return [self HexStringWithColor:color HasAlpha:NO];
}

+ (NSString *)HexStringWithColor:(UIColor *)color HasAlpha:(BOOL)hasAlpha {
    CGFloat r, g, b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    int rgb = (int)(r * 255.0f)<<16 | (int)(g * 255.0f)<<8 | (int)(b * 255.0f)<<0;
    if (hasAlpha) {
        rgb = (int)(a * 255.0f)<<24 | (int)(r * 255.0f)<<16 | (int)(g * 255.0f)<<8 | (int)(b * 255.0f)<<0;
    }
    return [NSString stringWithFormat:@"%06x", rgb];
}

@end
