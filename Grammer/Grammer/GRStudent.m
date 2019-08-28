//
//  GRStudent.m
//  Grammer
//
//  Created by gshopper on 2019/10/25.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "GRStudent.h"

@implementation GRStudent

- (void)dealloc
{
    NSLog(@"%s", __func__);
    if (self.observer) {
//        [self removeObserver:self.observer forKeyPath:@"name" context:nil];
    }
}
@end
