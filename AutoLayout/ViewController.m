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
    [self removePresentView:nil];
    switch (sender.tag) {
        case SubjectTypeIntrinsic:
            [self addIntrinsicLayoutView];
            break;
        case SubjectTypeCompressionResistance:
            [self addCompressionResistanceLayoutView];
            break;
        case SubjectTypeContentHugging:
            [self addHuggingView];
            break;
        default:
            break;
    }
    [self showPresentView];
    [hud hideAnimated:YES];
}

#pragma mark - 固有内容
- (void)addIntrinsicLayoutView {
//    -- label 内大大小 --
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
        make.size.equalTo(@(CGSizeMake(150, 44)));
    }];
//    -- 图片内在大小 --
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.presentView addSubview:imageView];
    UIImage *image = [UIImage imageWithContentsOfFile:@"datum"];
    imageView.image = image;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.presentView).multipliedBy(0.5);
        make.height.equalTo(imageView.width).multipliedBy(0.618);
        make.centerX.equalTo(self.presentView.centerX);
        make.top.equalTo(tipsLbl.bottom).offset(20);
    }];
    UILabel *imageSizeLbl = [[UILabel alloc] init];
    imageSizeLbl.textColor = UIColor.whiteColor;
    [self.presentView addSubview:imageSizeLbl];
    [imageSizeLbl makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(imageView);
    }];
    UILabel *originImageViewSizeLabl = [[UILabel alloc] init];
    [self.presentView addSubview:originImageViewSizeLabl];
    [originImageViewSizeLabl makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.presentView);
        make.top.equalTo(imageView.bottom).offset(20);
    }];
    [RACObserve(imageView, frame) subscribeNext:^(id  _Nullable x) {
        originImageViewSizeLabl.text = NSStringFromCGSize([x CGSizeValue]);
    }];
    BaseButton *changeImageBtn = [BaseButton buttonWithType:UIButtonTypeSystem];
    [changeImageBtn setTitle:@"resizeImage" forState:UIControlStateNormal];
    [self.presentView addSubview:changeImageBtn];
    [changeImageBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(150, 44));
        make.centerX.equalTo(self.presentView);
        make.top.equalTo(originImageViewSizeLabl.bottom).offset(10);
    }];
    changeImageBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        changeImageBtn.selected = !changeImageBtn.selected;
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"datum%d.png", changeImageBtn.selected + 1]];
        imageView.image = image;
        imageSizeLbl.text = NSStringFromCGSize(imageView.intrinsicContentSize);
        return [RACSignal empty];
    }];
}

#pragma mark - 压缩阻力
- (void)addCompressionResistanceLayoutView {
    BaseButton *compressBtn = [BaseButton buttonWithType:UIButtonTypeSystem];
    BaseButton *normalBtn = [BaseButton buttonWithType:UIButtonTypeSystem];
    BaseButton *uncompressBtn = [BaseButton buttonWithType:UIButtonTypeSystem];
    [compressBtn setTitle:@"阻力较大" forState:UIControlStateNormal];
    [normalBtn setTitle:@"默认阻力" forState:UIControlStateNormal];
    [uncompressBtn setTitle:@"阻小较小" forState:UIControlStateNormal];
    [self.presentView addSubview:compressBtn];
    [self.presentView addSubview:normalBtn];
    [self.presentView addSubview:uncompressBtn];
    
    [compressBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(CGSizeMake(40, 40));
//        make.size.equalTo(CGSizeMake(40, 40)).priority(MASLayoutPriorityDefaultLow);
//        make.size.equalTo(CGSizeMake(40, 40)).priority(MASLayoutPriorityDefaultMedium);
        make.size.equalTo(CGSizeMake(40, 40)).priority(MASLayoutPriorityDefaultHigh);

        make.center.equalTo(self.presentView).offset(CGPointMake(0, -100));
    }];
    [normalBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(CGSizeMake(40, 40));
//        make.size.equalTo(CGSizeMake(40, 40)).priority(MASLayoutPriorityDefaultLow);
//        make.size.equalTo(CGSizeMake(40, 40)).priority(MASLayoutPriorityDefaultMedium);
        make.size.equalTo(CGSizeMake(40, 40)).priority(MASLayoutPriorityDefaultHigh);
        make.center.equalTo(self.presentView);
    }];
    [uncompressBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(CGSizeMake(40, 40));
//        make.size.equalTo(CGSizeMake(40, 40)).priority(MASLayoutPriorityDefaultLow);
//        make.size.equalTo(CGSizeMake(40, 40)).priority(MASLayoutPriorityDefaultMedium);
        make.size.equalTo(CGSizeMake(40, 40)).priority(MASLayoutPriorityDefaultHigh);
        make.center.equalTo(self.presentView).offset(CGPointMake(0, 100));
    }];
    
    // 默认情况下，以下设置均没有效果，因为默认的约束都比压缩阻力的优先级高（或相等）。
    [compressBtn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [normalBtn setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [uncompressBtn setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}

#pragma mark - 内容吸附
- (void)addHuggingView {
    BaseButton *normalBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    BaseButton *lowBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    BaseButton *highBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [normalBtn setTitle:@"一般优先级" forState:UIControlStateNormal];
    [lowBtn setTitle:@"内容少，优先级低" forState:UIControlStateNormal];
    [highBtn setTitle:@"内容少，优先级高" forState:UIControlStateNormal];
    [self.presentView addSubview:normalBtn];
    [self.presentView addSubview:lowBtn];
    [self.presentView addSubview:highBtn];
    [lowBtn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.presentView).offset(CGPointMake(0, -100));
        make.size.equalTo(CGSizeMake(300, 44)).priority(MASLayoutPriorityDefaultMedium);
    }];
    [normalBtn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.presentView);
        make.size.equalTo(CGSizeMake(300, 44)).priority(MASLayoutPriorityDefaultMedium);
    }];
    [highBtn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.presentView).offset(CGPointMake(0, 100));
        make.size.equalTo(CGSizeMake(300, 44)).priority(MASLayoutPriorityDefaultMedium);
    }];
    [lowBtn setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [normalBtn setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [highBtn setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

#pragma mark - 显示与移除布局视图
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
