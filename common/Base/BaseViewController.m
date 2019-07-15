//
//  BaseViewController.m
//  AutoLayout
//
//  Created by mozihen on 2019/4/8.
//  Copyright © 2019 mzh. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
