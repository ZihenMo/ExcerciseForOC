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
    
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateAction:)];
    [roleView addGestureRecognizer:rotate];
    
    
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

/**
 拖拽移动
    拖拽时，持续更新translationInView得到的点（相对原始位置的距间）。
    1. transform带有make方法的变化方式也是相对原始的transform。
    2. 不带make的transform变形方法是相对传入的transform进行移动。
 */
- (void)panAction: (UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self.roleView];
    DDLogInfo(@"move:%@", NSStringFromCGPoint(point));
//    CGAffineTransform transform = self.roleView.transform;
//    self.roleView.transform = CGAffineTransformTranslate(transform, point.x, point.y);
    self.roleView.transform = CGAffineTransformMakeTranslation(point.x, point.y);

}

- (void)rotateAction: (UIRotationGestureRecognizer *)rotate {
    DDLogInfo(@"rotate:%@", rotate);
    CGAffineTransform transform = self.roleView.transform;
    self.roleView.transform = CGAffineTransformRotate(transform, rotate.rotation);
}


#pragma mark - GestureRecognizeDelegate

@end
