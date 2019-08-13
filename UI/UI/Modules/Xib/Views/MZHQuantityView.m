//
//  MZHQuantityView.m
//  UI
//
//  Created by gshopper on 2019/8/7.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "MZHQuantityView.h"

@interface MZHQuantityView()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet BaseButton *reductButton;
@property (weak, nonatomic) IBOutlet BaseButton *increaseButton;

@end
@implementation MZHQuantityView

//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        [self initilized];
//    }
//    return self;
//}
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self initilized];
//    }
//    return self;
//}

- (void)initilized {
    self.value = 1;
    self.step = 1;
    self.min = 1;
    self.max = NSIntegerMax;
}

- (void)awakeFromNib {
    [self initilized];
    [super awakeFromNib];
    [self.reductButton addTarget:self action:@selector(reduceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.increaseButton addTarget:self action:@selector(increaseAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)reduceAction: (UIButton *)sender {
    NSInteger value = self.value - self.step;
    if (value >= self.min) {
        self.value = value;
    }
}
- (void)increaseAction: (UIButton *)sender {
    NSInteger value = self.value + self.step;
    if (value <= self.max) {
        self.value = value;
    }
}

- (void)setValue:(NSInteger)value {
    _value = value;
    self.textField.text = @(value).stringValue;
}
@end
