/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

CGPoint QICGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)
@property CGPoint qi_origin;
@property CGSize qi_size;

@property (readonly) CGPoint qi_bottomLeft;
@property (readonly) CGPoint qi_bottomRight;
@property (readonly) CGPoint qi_topRight;

@property CGFloat qi_height;
@property CGFloat qi_width;

@property CGFloat qi_top;
@property CGFloat qi_left;

@property CGFloat qi_bottom;
@property CGFloat qi_right;
@property CGFloat qi_centerX;
@property CGFloat qi_centerY;

- (void)moveBy:(CGPoint) delta;
- (void)scaleBy:(CGFloat) scaleFactor;
- (void)fitInSize:(CGSize) aSize;
@end
