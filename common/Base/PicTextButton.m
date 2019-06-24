//
//  PicTextButton.m
//  SendbirdChat
//
//  Created by mozihen on 2019/6/24.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "PicTextButton.h"

@implementation PicTextButton

- (instancetype)initWithPicTextType:(PicTextType)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
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
