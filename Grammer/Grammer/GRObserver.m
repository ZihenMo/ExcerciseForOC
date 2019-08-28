//
//  GRObserver.m
//  Grammer
//
//  Created by gshopper on 2019/10/25.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "GRObserver.h"
#import "GRStudent.h"

@implementation GRObserver


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == (__bridge void * _Nullable)(GRPerson.class)) {
        if ([keyPath isEqualToString:@"name"]) {
               NSLog(@"%@ - new name: %@", GRPerson.className, change[NSKeyValueChangeNewKey]);
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
@implementation GRNameObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    id newValue = change[NSKeyValueChangeNewKey];
    if (context == (__bridge void * _Nullable)(GRStudent.class)) {
        if ([keyPath isEqualToString:@"name"]) {
               NSLog(@"%@ - new name: %@", GRStudent.className, change[NSKeyValueChangeNewKey]);
        }

        if ([keyPath isEqualToString:@"age"]) {
            NSLog(@"%@ - new age: %@", GRStudent.className, newValue);
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
