//
//  DataUpdateOperation.m
//  RecycleReference
//
//  Created by mozihen on 2019/4/15.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "DataUpdateOperation.h"

@implementation DataUpdateOperation


- (void)startWithDelegate:(id)delegate withSelector:(SEL)selector {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 回主线程操作
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([delegate respondsToSelector:selector]) {
                [delegate performSelector:selector withObject:@[] afterDelay:0];
            }
        });
    });
}

- (void)dealloc {
    NSLog(@"%s [called]", __PRETTY_FUNCTION__);
}

@end
