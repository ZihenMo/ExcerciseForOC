//
//  AppDelegate.m
//  UI
//
//  Created by mozihen on 2019/4/17.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <UI-Swift.h>
#import <Bugly/Bugly.h>

static NSString * const kBuglyAppID = @"dde5d68d17";
static NSString * const kBuglyAppKey = @"f48f3854-782b-44cf-ac48-e5796801edd3";

@interface AppDelegate ()
@property (strong, nonatomic) id paws;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Bugly startWithAppId:kBuglyAppID];
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    NSString *value = processInfo.environment[@"gesturePaws"];
    if ([value isEqualToString:@"1"]) {
        self.paws = [Monkey getPaws:self.window];
    }

    [self configureDDLog];
    return YES;
}

#pragma mark - Configuration
- (void)configureDDLog {
    [DDLog addLogger: [DDTTYLogger sharedInstance]];  // 控制台
//    [DDLog addLogger: [DDOSLogger sharedInstance]];   // 系统日志器
    // 设置日志文件夹名称，默认Logs
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 刷新频率 24小时
    fileLogger.maximumFileSize = 1024 * 1024 * 2;   // 限制日志大小
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;    // 7个文件，最多存储近一周的日志
    [DDLog addLogger:fileLogger];

//    DDLogVerbose(@"Verbose");   // 详细日志
//    DDLogDebug(@"Debug");       // 调试日志
//    DDLogInfo(@"Info");         // 信息日志
//    DDLogWarn(@"Warn");         // 警告日志
//    DDLogError(@"Error");       // 错误日志
}

@end
