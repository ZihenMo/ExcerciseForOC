//
//  ButtonViewController.m
//  UI
//
//  Created by gshopper on 2019/4/18.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "ButtonViewController.h"
#import <UIButton+WebCache.h>


@interface ButtonViewController ()

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 40, 100);
    [btn sd_setImageWithURL:[NSURL URLWithString:@"https://ws.izenecdn.com/cms/library/flags/cn.png"] forState:UIControlStateNormal];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 2, 20);
    btn.titleEdgeInsets = UIEdgeInsetsMake(-10, -50, -10, -10);
    [btn setTitle:@"CN" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:btn];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
