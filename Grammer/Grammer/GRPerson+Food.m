//
//  Person+Food.m
//  Grammer
//
//  Created by gshopper on 2019/10/25.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "GRPerson+Food.h"

#import <AppKit/AppKit.h>


@implementation GRPerson (Food)

- (void)doCategoryMethod {
    NSLog(@"food");
}

- (void)privateExtension {
    NSLog(@"extension override %s", __func__);
}

@end
