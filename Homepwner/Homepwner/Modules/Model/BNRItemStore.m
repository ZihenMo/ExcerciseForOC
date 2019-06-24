//
//  BNRItemStore.m
//  Homepwner
//
//  Created by gshopper on 2019/6/12.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "BNRItemStore.h"
static BNRItemStore *singleton = nil;
@implementation BNRItemStore

+ (instancetype)share {
    if (singleton == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            singleton = [[BNRItemStore alloc] init];
        });
    }
    return singleton;
}

- (instancetype)init
{
    return [BNRItemStore share];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (singleton == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            singleton = [[BNRItemStore alloc] init];
        });
    }
    return singleton;
}
#if !__has_feature(objc_arc)    // MRC
- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return singleton;
}
#endif


@end
