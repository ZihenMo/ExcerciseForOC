//
//  GestureRecognizeViewController.m
//  UI
//
//  Created by gshopper on 2019/7/15.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "GestureRecognizeViewController.h"

@interface GestureRecognizeViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *roleView;
@end

@implementation GestureRecognizeViewController
#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI {
    UIView *roleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    roleView.center = self.view.center;
    roleView.backgroundColor = UIColor.redColor;
    [self.view addSubview:roleView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [roleView addGestureRecognizer:tap];
    tap.delegate = self;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    [roleView addGestureRecognizer: swipe];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [roleView addGestureRecognizer:pan];
    
    self.roleView = roleView;
}

#pragma mark - Actions
- (void)tapAction: (UITapGestureRecognizer *)tap {
    [self.view show:@"tap"];
}
- (void)swipeAction: (UISwipeGestureRecognizer *)swipe {
    [self.view show:@"swipe"];
    self.roleView.backgroundColor = UIColor.randomColor;
}
- (void)panAction: (UIPanGestureRecognizer *)pan {
    
}


#pragma mark - GestureRecognizeDelegate

@end
