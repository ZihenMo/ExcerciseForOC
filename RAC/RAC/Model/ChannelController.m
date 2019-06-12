//
//  ChannelController.m
//  RAC
//
//  Created by gshopper on 2019/6/6.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "ChannelController.h"
#import <SafariServices/SafariServices.h>

@interface ChannelController ()<SFSafariViewControllerDelegate>

@end

@implementation ChannelController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *maskView = [UIView new];
    [self.view addSubview:maskView];
    maskView.backgroundColor = UIColor.redColor;
    [maskView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(@(CGSizeMake(100, 100)));
        make.center.equalTo(self.view);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *url = @"https://www.gshopper.com";
    SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:^{
//        vc.view.hidden = YES;
    }];
}

#pragma mark - SFSafariViewControllerDelegate
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    
}
@end
