//
//  UIDevice+Tools.m
//  UI
//
//  Created by gshopper on 2019/9/2.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "UIDevice+Tools.h"

@implementation UIDevice (Tools)

+ (BOOL)isJailbreak {
    NSString *cydiaPath = @"/Applications/Cydia.app";
    return [[NSFileManager defaultManager] fileExistsAtPath:cydiaPath];
}

@end
