//
//  ButtonViewController.m
//  UI
//
//  Created by gshopper on 2019/5/14.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "ButtonViewController.h"

@interface ButtonViewController ()
@property (weak, nonatomic) IBOutlet BaseButton *btn;

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.btn setTitle:@"点击屏幕切换按钮状态" forState:UIControlStateNormal];
    // 以纯色制作背景图,以供不同按钮状态切换
//    UIImage *normalBgImage = [UIImage imageWithColor:[UIColor colorWithRGB:0xFF0000] frame:self.btn.frame];
//    UIImage *disableBgImage = [UIImage imageWithColor:[UIColor lightGrayColor] frame:self.btn.frame];
//    [self.btn setBackgroundImage:normalBgImage forState:UIControlStateNormal];
//    [self.btn setBackgroundImage:disableBgImage forState:UIControlStateDisabled];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.btn.enabled = !self.btn.isEnabled;
}
@end
