//
//  MZShadowRadiusView.m
//  UI
//
//  Created by gshopper on 2019/9/26.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "MZShadowRadiusView.h"
static const CGFloat MZDefaultRadius = 16.f;
@implementation MZShadowRadiusView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.contentMode = UIViewContentModeRedraw;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeRedraw;
    }
    return self;
}
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGFloat)radii inRect: (CGRect)rect{
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radii, radii)];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (void)drawRect:(CGRect)rect {
    [self addRoundedCorners:UIRectCornerAllCorners withRadii:MZDefaultRadius inRect:rect];
}

@end
