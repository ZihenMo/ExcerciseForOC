//
//  UIColor+Tools.h
//  Infrastructure
//
//  Created by gshopper on 2019/3/21.
//  Copyright © 2019 mzh. All rights reserved.
//

#import <UIKit/UIKit.h>

static const UInt32 COLOR_BUTTON_BACKGROUND_NORMAL = 0xc3c3c3;
static const UInt32 COLOR_BUTTON_BACKGROUND_SELECTED = 0xd66666;

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Tools)

+ (instancetype) colorWithRGB: (UInt32) rgb;
- (instancetype) initWithRGB: (UInt32) rgb;
+ (instancetype) colorWithRGB: (UInt32) rgb alpha:(CGFloat)alpha;
- (instancetype) initWithRGB: (UInt32)rgb alpha:(CGFloat)alpha;
+ (instancetype) randomColor;

@end

NS_ASSUME_NONNULL_END
