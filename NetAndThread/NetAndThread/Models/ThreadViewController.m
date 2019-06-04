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
@property (nonatomic, strong) NSThread *thread;
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
    [self threadCommunication];
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

/**
 创建线程
 */
- (void)createThread {
    // 1.1 创建并启动任务 block形式
    [NSThread detachNewThreadWithBlock:^{
        NSLog(@"当前线程:%@", [NSThread currentThread]);
        NSLog(@"---block task---");
    }];
    // 1.2 创建并启动任务 方法形式
    [NSThread detachNewThreadSelector:@selector(task) toTarget:self withObject:nil];
    // 1.3 创建线程，等待启动
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"当前线程:%@", [NSThread currentThread]);
        NSLog(@"--block task2--");
    }];
    self.thread = thread;
    // 2. 启动线程
    [thread start];
}

/**
 线程通信
 */
- (void)threadCommunication {
    // 线程star之后便不可再用
//    NSThread *thread = self.thread;
//    [self performSelector:@selector(task2) onThread:thread withObject:nil waitUntilDone:NO];
    // 切换至主线程执行
    [self performSelectorOnMainThread:@selector(task2) withObject:nil waitUntilDone:NO];
}

#pragma mark - Task
- (void)task {
    NSThread *thread = [NSThread currentThread];
    NSLog(@"当前线程:%@ ,task1", thread);
    for (NSInteger i = 0; i < MAXFLOAT; ++i) {
        [NSThread sleepForTimeInterval:2];
        NSLog(@"%s", __func__);
    }
}
- (void)task2 {
    NSThread *thread = [NSThread currentThread];
    NSLog(@"当前线程:%@, task2", thread);
    for (NSInteger i = 0; i < 10; ++i) {
        [NSThread sleepForTimeInterval:2];
        NSLog(@"%s", __func__);
    }
}
@end



