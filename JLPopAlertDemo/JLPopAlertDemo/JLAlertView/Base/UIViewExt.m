/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import "UIViewExt.h"

CGPoint QICGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView (ViewGeometry)

// Retrieve and set the origin
- (CGPoint)qi_origin {
    return self.frame.origin;
}

- (void)setQi_origin:(CGPoint)origin {
    CGRect newframe = self.frame;
    newframe.origin = origin;
    self.frame = newframe;
}



// Retrieve and set the size
- (CGSize) qi_size
{
    return self.frame.size;
}

- (void)setQi_size:(CGSize)aSize {
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint)qi_bottomRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)qi_bottomLeft {
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)qi_topRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat)qi_height {
    return self.frame.size.height;
}

- (void)setQi_height:(CGFloat)newheight {
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat)qi_width {
    return self.frame.size.width;
}

- (void)setQi_width:(CGFloat)newwidth {
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat)qi_top {
    return self.frame.origin.y;
}

- (void)setQi_top:(CGFloat)newtop {
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)qi_left {
    return self.frame.origin.x;
}

- (void)setQi_left:(CGFloat)newleft {
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)qi_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setQi_bottom:(CGFloat)newbottom {
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)qi_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setQi_right:(CGFloat)newright {
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (CGFloat)qi_centerX {
    return self.center.x;
}

- (void)setQi_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)qi_centerY {
    return self.center.y;
}

- (void)setQi_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

// Move via offset
- (void)moveBy:(CGPoint)delta {
	CGPoint newcenter = self.center;
	newcenter.x += delta.x;
	newcenter.y += delta.y;
	self.center = newcenter;
}

// Scaling
- (void)scaleBy:(CGFloat)scaleFactor {
	CGRect newframe = self.frame;
	newframe.size.width *= scaleFactor;
	newframe.size.height *= scaleFactor;
	self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void)fitInSize:(CGSize)aSize {
	CGFloat scale;
	CGRect newframe = self.frame;
	
	if (newframe.size.height && (newframe.size.height > aSize.height))
	{
		scale = aSize.height / newframe.size.height;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	if (newframe.size.width && (newframe.size.width >= aSize.width))
	{
		scale = aSize.width / newframe.size.width;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	self.frame = newframe;	
}

@end
