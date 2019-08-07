//
//  BaseViewController.m
//  AutoLayout
//
//  Created by mozihen on 2019/4/8.
//  Copyright © 2019 mzh. All rights reserved.
//

#import "MZHViewController.h"
#import "MZHNavigationBar.h"

@interface MZHViewController ()

@end

@implementation MZHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DDLogDebug(@"-[%@ viewDidLoad]",NSStringFromClass(self.class));
}

- (void)dealloc {
    DDLogDebug(@"-[%@ dealloc]",NSStringFromClass(self.class));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setupNavigationBar {
    [self.view addSubview:self.navigationBar];
}

#pragma mark - Getter & Setter
- (MZHNavigationBar *)navigationBar {
    if (_navigationBar == nil) {
        _navigationBar = [[MZHNavigationBar alloc] init];
    }
    return _navigationBar;
}


@end
