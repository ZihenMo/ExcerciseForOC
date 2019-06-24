//
//  CGDrawViewController.m
//  UI
//
//  Created by gshopper on 2019/5/14.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "CGDrawViewController.h"
#import "BGView.h"

@interface CGDrawViewController ()

@end

@implementation CGDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    BGView *backgroundView = [[BGView alloc] init];
    [self.view insertSubview:backgroundView atIndex:0]; // 插入到底层
    [backgroundView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
//    backgroundView.layer.zPosition = -1;// 仅移动图层，事件依然受影响
}

- (IBAction)drawConcentricCircleAction:(id)sender {

}
- (IBAction)drawImageAction:(id)sender {
}



@end
