//
//  main.m
//  Grammer
//
//  Created by gshopper on 2019/6/5.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRPerson.h"
#import "GRPerson+Tool.h"
#import "GRPerson+Food.h"
#import "GRStudent.h"
#import "GRObserver.h"

// 前置声明
void variableParams(NSString *format, ...);
void duration(void);
void excuteCategoryAndExtesionMetond(void);
void kvoTrap(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        duration();
//        excuteCategoryAndExtesionMetond();
        kvoTrap();
    }
    return 0;
}


#pragma mark - KVO
void kvoTrap(void) {
    GRObserver *observer = [GRObserver new];
    GRNameObserver *nameObserver = [GRNameObserver new];
    GRStudent *student = [[GRStudent alloc] init];
    student.name = @"王嵬";
//    GRPerson *person = [GRPerson new];
//    person.name = @"老子";
    student.observer = nameObserver;
    
//    [person addObserver:observer forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    [person addObserver:nameObserver forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
    [student addObserver:nameObserver forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(student.class)];
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
        student.name = @"王新铭";
        student.age = 18;
//        person.name = @"爸爸";
//        person.age = 21;
//    }];
//    NSRunLoop *runLoop = [NSRunLoop mainRunLoop];
//    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
//    [runLoop run];
}

#pragma mark - 分类与扩展 加载与执行顺序

/// 多个分类的同名方法的实现会相互覆盖，由分类的加载顺序（最晚加载）决定最终调用。
/// 可更改分类文件加载（编译）顺序来验证结果。
/// 分类或扩展都不应重写原有方法student    GRStudent *    0x100697270    0x0000000100697270
void excuteCategoryAndExtesionMetond(void) {
    GRPerson *person = [[GRPerson alloc] init];
//    [person doCategoryMethod];
    [person doExtensionMethod];
    [person doSomething];
    [person doB];
}

#pragma mark - 可变参数列表
/**
 * 不定参数的使用方法
 */
void variableParams(NSString *format, ...) {

    va_list args;
    va_start(args, format);
    
    NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    NSLog(@"str: %@", str);
}

#pragma mark - 时间相关
void CFDuration() {
    // 绝对时间，从2001年开始
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    // do something
    [NSThread sleepForTimeInterval:3];
    CFTimeInterval endTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"duration: %lf", endTime - startTime);
}
void NSDuration() {
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    [NSThread sleepForTimeInterval:3];
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"duration: %lf", endTime - startTime);
}
void duration() {
    CFDuration();
    NSDuration();
}

