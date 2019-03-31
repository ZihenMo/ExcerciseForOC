//
//  ViewController.m
//  AutoLayout
//
//  Created by gshopper on 2019/3/31.
//  Copyright © 2019 mzh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIStackView *stackView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


# pragma mark - UI
- (void)setupUI {
    [self.view addSubview:self.stackView];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem:self.stackView attribute:NSLayoutAttributeTop multiplier:1.0 constant:50];
    
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeading relatedBy: NSLayoutRelationEqual toItem:self.stackView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:30];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy: NSLayoutRelationEqual toItem:self.stackView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:50];
    
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy: NSLayoutRelationEqual toItem:self.stackView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:30];

    
    [self.view addConstraints:@[topConstraint, leadingConstraint, bottomConstraint, trailingConstraint]];
}


# pragma mark - getter & setter
- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
        [_stackView setDistribution:UIStackViewDistributionFillEqually];
    }
    return _stackView;
}
@end
