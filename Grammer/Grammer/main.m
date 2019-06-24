//
//  main.m
//  Grammer
//
//  Created by gshopper on 2019/6/5.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <Foundation/Foundation.h>
void test(NSString *format, ...);
void duration();
int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        test(@"hello:");
//        test(@"你大爷%@", @"滚出");
        duration();
    }
    return 0;
}


/**
 * 不定参数
 */
void test(NSString *format, ...) {

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

