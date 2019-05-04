//
//  UIColor+Tools.m
//  Infrastructure
//
//  Created by gshopper on 2019/3/21.
//  Copyright © 2019 mzh. All rights reserved.
//

#import "UIColor+Tools.h"

@implementation UIColor (Tools)

+ (instancetype)colorWithRGB:(UInt32)rgb {
    return [[self alloc] initWithRGB:rgb];
}

+ (instancetype)colorWithRGB:(UInt32)rgb alpha:(CGFloat)alpha {
    return [[self alloc] initWithRGB:rgb alpha:alpha];
}

- (instancetype)initWithRGB:(UInt32)rgb {
    return [self initWithRGB:rgb alpha:1.0];
}

- (instancetype)initWithRGB:(UInt32)rgb alpha:(CGFloat)alpha {
    return [self initWithRed: ((rgb & 0xFF0000) >> 16) / 255.0f
                       green:((rgb & 0xFF00) >> 8) / 255.0f
                        blue:(rgb & 0xFF) / 255.0f alpha:alpha];
}

+ (instancetype)randomColor {
    uint32_t rgb = arc4random() % 0xFFFFFF;
    return [self colorWithRGB:rgb];
}
@end
