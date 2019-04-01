//
//  ViewController.m
//  AutoLayout
//
//  Created by gshopper on 2019/3/31.
//  Copyright © 2019 mzh. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "BaseButton.h"

typedef NS_ENUM(NSInteger, SubjectType) {
    SubjectTypeIntrinsic,
    SubjectTypeCompressionResistance,
    SubjectTypeContentHugging
};

@interface ViewController ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) NSArray *subjects;
@property (nonatomic, strong) UIView *presentView;





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


# pragma mark - UI
- (void)setupUI {
    [self.view addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(50, 30, 50, 30));
        
    }];
    [self addMenus];
}

- (void)addMenus {
    [self.subjects enumerateObjectsUsingBlock:^(id  _Nonnull subject, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *subjectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [subjectBtn setTitle:subject forState:UIControlStateNormal];
        subjectBtn.tag = idx;
        [subjectBtn addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.stackView addArrangedSubview:subjectBtn];
    }];
}

#pragma mark - event
- (void)menuAction: (UIButton *)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:sender animated:YES];
    switch (sender.tag) {
        case SubjectTypeIntrinsic:
            [self ShowIntrinsicLayoutView];
            break;
            
        default:
            break;
    }
    [hud hideAnimated:YES];
}

/**
 固有内容布局
 */
- (void)ShowIntrinsicLayoutView {
    UILabel *roleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    roleLbl.backgroundColor = [UIColor randomColor];
    roleLbl.text = @"拥有固有内容尺寸的标签视图";
    [self.presentView addSubview:roleLbl];
    [roleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.presentView).centerOffset(CGPointMake(0,-100));
    }];
    UILabel *tipsLbl = [[UILabel alloc] init];
    tipsLbl.backgroundColor = UIColor.randomColor;
    [self.presentView addSubview:tipsLbl];
    [tipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.presentView);
    }];
    UITextField *textField = [[UITextField alloc] init];
    textField.textColor = UIColor.whiteColor;
    textField.backgroundColor = UIColor.randomColor;
    [self.presentView addSubview:textField];
    [textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        roleLbl.text = x;
        tipsLbl.text = NSStringFromCGSize(roleLbl.intrinsicContentSize);
    }];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.presentView).centerOffset(CGPointMake(0, -150));
        make.size.mas_equalTo(CGSizeMake(150, 44));
    }];
    [self showPresentView];
}

- (void)showPresentView {
    [self.view addSubview:self.presentView];
    [self.presentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(self.view.bounds.size.height);
    }];
    [UIView animateWithDuration:3.5 animations:^{
        [self.presentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
        }];
    }];
}
- (void)removePresentView:(UITapGestureRecognizer *)tap {
    [self.presentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.presentView removeFromSuperview];
}

# pragma mark - getter & setter
- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
        [_stackView setDistribution:UIStackViewDistributionFillEqually];
        [_stackView setAlignment:UIStackViewAlignmentFill];
        [_stackView setSpacing:10.0];
        [_stackView setAxis:UILayoutConstraintAxisVertical]; // 排列方向
        _stackView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
    }
    return _stackView;
}
- (NSArray *)subjects {
    if (!_subjects) {
        _subjects = @[@"固有内容大小",@"压缩阻力",
                      @"内容支撑"];
    }
    return _subjects;
}
- (UIView *)presentView {
    if (!_presentView) {
        _presentView = [[UIView alloc] initWithFrame:CGRectZero];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removePresentView:)];
        _presentView.backgroundColor = [UIColor colorWithRed:200.0/256.0 green:170.0/256.0 blue:180.0/256.0 alpha:1];
        [_presentView addGestureRecognizer:tap];
    }
    return _presentView;
}

@end
