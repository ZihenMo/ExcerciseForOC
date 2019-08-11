//
//  ALButton.m
//  AutoLayout
//
//  Created by mozihen on 2019/4/1.
//  Copyright © 2019 mzh. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    BaseButton *button = [super buttonWithType:buttonType];
    [button configure];
    return button;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure {
    self.backgroundColor = UIColor.orangeColor;
    [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self setTitleColor:UIColor.blueColor forState:UIControlStateFocused];
    [self setTitleShadowColor:UIColor.grayColor forState:UIControlStateNormal];
}

- (void)setType:(PicTextType)type {
    [self layoutIfNeeded]; //  必要，为获取正确的size
    CGSize titleSize = self.titleLabel.bounds.size;
    CGSize imageSize = self.imageView.bounds.size;
    CGFloat interval = 1.0;
    switch (type) {
        case PicTextTypePicTop:
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, titleSize.height + interval, -(titleSize.width + interval))];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + interval, -(imageSize.width + interval), 0, 0)];
            break;
        case PicTextTypePicBottom:
            [self setImageEdgeInsets:UIEdgeInsetsMake(titleSize.height + interval, 0, 0, -(titleSize.width + interval))];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(-(imageSize.height + interval), -(imageSize.width + interval), 0, 0)];
            break;
        case PicTextButtonPicLeft:
            break;
        case PicTextTypePicRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
            break;
        default:
            break;
    }
}

@end
