//
//  ThreadViewController.m
//  NetAndThread
//
//  Created by mozihen on 2019/5/13.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "ThreadViewController.h"
#import <pthread/pthread.h>

@interface ThreadViewController ()
@end

void *task (void *name) {
    
    for (NSInteger i = 0; i < 1000000000; ++i) {
        if (i % 100000000 == 0) {
            NSLog(@"task...");
        }
    }
    return NULL;
}

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark - Actions
- (IBAction)createAction:(UIButton *)sender {
    if (sender.tag == 1) {
        [self createPthread];
    }
    else {
        [self createThread];
    }
}
- (IBAction)switchAction:(UIButton *)sender {
}
- (IBAction)destoryAction:(UIButton *)sender {
}

#pragma mark - pthread
// p指POSIX
- (void)createPthread {
    pthread_t thread;
    NSString *name = @"taskName";
    // 参数分别为：
    //  线程变量地址
    //  线程属性
    //  线程运行的函数（指针）
    //  函数参数
    pthread_create(&thread, NULL, task, (__bridge void *)(name));
}
#pragma mark - NSThread
- (void)createThread {
    // 1.1 创建并启动任务 block形式
    [NSThread detachNewThreadWithBlock:^{
        NSLog(@"当前线程:%@", [NSThread currentThread]);
        NSLog(@"---block task---");
    }];
    // 1.2 创建并启动任务 方法形式
    [NSThread detachNewThreadSelector:@selector(task) toTarget:self withObject:nil];
//    [NSThread mainThread];
    
}

#pragma mark - Task
- (void)task {
    for (NSInteger i = 0; i < MAXFLOAT; ++i) {
        if (i % 100000000 == 0) {
            NSLog(@"%s", __func__);
        }
    }
}
@end



