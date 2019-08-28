//
//  Person.m
//  Grammer
//
//  Created by gshopper on 2019/7/2.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "GRPerson.h"

@interface GRPerson()

- (void)privateExtension;
@end

@implementation GRPerson
- (void)doSomething {
    NSLog(@"%s", __func__);
}

- (void)doB {
    NSLog(@"%s need to call %@",__func__, NSStringFromSelector(@selector(doSomething)));
    [self doSomething];
    [self privateExtension];
}


- (void)doExtensionMethod {
    NSLog(@"%s", __func__);
}

- (void)privateExtension {
    NSLog(@"%s call it on inner", __func__);
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    if (self.observer) {
        NSLog(@"self.class: %@", self.class);
        [self removeObserver:self.observer forKeyPath:@"name" context:(__bridge void * _Nullable)(self.class)];
    }
}
@end
