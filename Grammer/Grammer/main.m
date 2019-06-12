//
//  main.m
//  Grammer
//
//  Created by gshopper on 2019/6/5.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <Foundation/Foundation.h>
void test(NSString *format, ...);
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test(@"hello:");
        test(@"你大爷%@", @"滚出");
    }
    return 0;
}

void test(NSString *format, ...) {

    va_list args;
    va_start(args, format);

    NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    NSLog(@"str: %@", str);
}
