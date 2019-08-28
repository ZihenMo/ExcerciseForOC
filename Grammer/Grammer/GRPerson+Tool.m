//
//  Person+Tool.m
//  Grammer
//
//  Created by gshopper on 2019/7/2.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "GRPerson+Tool.h"

@implementation GRPerson (Tool)
- (void)doCategoryMethod {
    NSLog(@"Tool");
}

/// 重写扩展方法
//- (void)doExtensionMethod {
////    [self doExtensionMethod]; // 递规调用自身
//    NSLog(@"分类重写扩展方法");
//}
//
//
///// 重写原有方法
//- (void)doSomething {
////    [self doSomething];
//    NSLog(@"分类重写原有方法");
//}
@end
