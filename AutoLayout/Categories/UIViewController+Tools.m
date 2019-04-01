//
//  UIViewController+Tools.m
//  Infrastructure
//
//  Created by gshopper on 2019/3/21.
//  Copyright © 2019 mzh. All rights reserved.
//

#import "UIViewController+Tools.h"

@implementation UIViewController (Tools)

- (void)showAlertWith:(NSString *) message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [[UIViewController getCurrentViewController] presentViewController:alert animated:YES completion:nil];
}

+ (UIViewController *)getCurrentViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    __block UIViewController* (^getCurrentVCBlock)(UIViewController *) = ^(UIViewController *rootVC){
        UIViewController *currentVC;
        if ([rootVC presentedViewController]) {
            rootVC = [rootVC presentedViewController];
        }
        if ([rootVC isKindOfClass:[UITabBarController class]]) {
            currentVC = getCurrentVCBlock([(UITabBarController *)rootVC selectedViewController]);
        } else if ([rootVC isKindOfClass:[UINavigationController class]]){
            currentVC =  getCurrentVCBlock([(UINavigationController *)rootVC visibleViewController]);
        } else {
            currentVC = rootVC;
        }
        return currentVC;
    };
    UIViewController *currentVC = getCurrentVCBlock(rootViewController);
    return currentVC;
}

@end
