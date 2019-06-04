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
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}
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
//    self.btn.enabled = !self.btn.isEnabled;
//    self.btn.layer.cornerRadius = 8.0;
    self.btn.layer.borderWidth = 4.0;
    self.btn.layer.borderColor = UIColor.redColor.CGColor;
}

/**
 运动效果
 */
- (IBAction)motionAction:(id)sender {
    // 视差效果，倾斜设备时由运动传感器触发
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    [bgView addTapAction:^(UIView * _Nonnull sender) {
        [sender removeFromSuperview];
    }];
    bgView.backgroundColor = UIColor.orangeColor;
    NSString *message = @"倾斜设备触发";
    for (NSInteger i = 0; i < 10; ++i) {
        UILabel *label = [[UILabel alloc] init];
        label.text = message;
        [label sizeToFit];
        // 确保随机位置在屏幕内
        int width = bgView.bounds.size.width - label.frame.size.width;
        int height = bgView.bounds.size.height - label.frame.size.height;
        CGFloat x = arc4random() % width;
        CGFloat y = arc4random() % height;
        label.frame = CGRectMake(x, y, label.frame.size.width, label.frame.size.height);
        [bgView addSubview:label];
        [self addEffection:label];
    }
    [self.view addSubview:bgView];
}

/**
 添加视差效果
    添加水平和垂直两个传感差值效果（可往两个方向移动）
 @param view 依附视图
 */
- (void)addEffection: (UIView *)view {
    // 差值传感效果
    UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalEffect.minimumRelativeValue = @(-25);
    horizontalEffect.maximumRelativeValue = @(25);
    [view addMotionEffect:horizontalEffect];
    
    UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalEffect.minimumRelativeValue = @(-25);
    verticalEffect.maximumRelativeValue = @(25);
    [view addMotionEffect:verticalEffect];
}




@end
