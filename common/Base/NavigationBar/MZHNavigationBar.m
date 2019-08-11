
//
//  BaseNavigationBar.m
//  UI
//
//  Created by gshopper on 2019/7/31.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "MZHNavigationBar.h"

static const CGFloat kBarHeight = 44.f;

@implementation MZHNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, MZH_SCREEN_SIZE.width, kBarHeight)];
}

- (instancetype)initWithTitle:(NSString *)title {
    return [self init];
}


@end
