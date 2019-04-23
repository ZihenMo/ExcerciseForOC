//
//  NibLoadView.m
//  UI
//
//  Created by mozihen on 2019/4/21.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "NibLoadView.h"

@implementation NibLoadView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = UIColor.randomColor;
    NSLog(@"%s -- frame:%@", __PRETTY_FUNCTION__, NSStringFromCGRect(self.frame));
}

@end
