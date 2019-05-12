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

@end



