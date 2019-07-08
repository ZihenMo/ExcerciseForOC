//
//  UIViewController+Tools.m
//  ASDK
//
//  Created by gshopper on 2019/6/28.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "UIViewController+Tools.h"

@implementation UIViewController (Tools)
- (void)doSomething {
    NSLog(@"%s", __func__);
    
}

+ (void)load {
    NSLog(@"----内部方法----");
    NSLog(@"load vc %s", __func__);
}
@end
