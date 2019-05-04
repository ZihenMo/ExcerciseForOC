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

- (void)configure {
    self.backgroundColor = UIColor.orangeColor;
    [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self setTitleColor:UIColor.blueColor forState:UIControlStateFocused];
    [self setTitleShadowColor:UIColor.grayColor forState:UIControlStateNormal];
}

@end
