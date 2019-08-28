//
//  XibNestingViewController.m
//  UI
//
//  Created by gshopper on 2019/10/21.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "XibNestingViewController.h"
#import "MZHQuantityView.h"

@interface XibNestingViewController ()
@property (weak, nonatomic) IBOutlet MZHQuantityView *quantityView;
@property (nonatomic, strong) IBOutlet UIView *colorView;
@property (nonatomic, strong) IBOutlet UIProgressView *progress;

@end

@implementation XibNestingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect colorFrame = self.colorView.frame;
    colorFrame.origin = CGPointMake(0, 100);
    self.colorView.frame = colorFrame;
    [self.view addSubview:self.colorView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.colorView.backgroundColor = UIColor.randomColor;
}

- (UIView *)colorView {
    if (_colorView == nil) {
        [[NSBundle mainBundle]loadNibNamed:@"MZHColorView" owner:self options:nil];
    }
    return _colorView;
}


@end
