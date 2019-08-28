//
//  ViewController.m
//  RAC
//
//  Created by mozihen on 2019/4/2.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "HomeViewController.h"
#import "CaculatorController.h"
#import "LocalizedViewController.h"
#import "PartViewController.h"
#import "ChannelController.h"
@interface HomeViewController ()
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, assign) NSTimeInterval lastTimeStamp;
@end

@implementation HomeViewController
- (IBAction)switchLanguageAction:(UIButton *)sender {
}
- (IBAction)ssss:(id)sender {
}

- (IBAction)switchLanguage:(UIButton *)sender {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

# pragma mark - UI
- (void)setupUI {
    // -- stackView --
    [self.view addSubview:self.stackView];
    [self.stackView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(self.view).multipliedBy(0.618);
    }];
    // -- add menus --
    NSString *t1 =  Localized(@"calculator");
    NSArray *menus = @[t1, @"切换本地化语言", @"局部变量RAC", @"渠道测试"];
    [self addMenus: menus];
    [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
}

- (void)addMenus: (NSArray<NSString *> *)menus {
    [menus enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BaseButton *menuBtn = [BaseButton buttonWithType:UIButtonTypeSystem];
        [menuBtn setTitle:obj forState:UIControlStateNormal];
        menuBtn.tag = idx;
        menuBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            UIViewController *nextVC;
            switch (menuBtn.tag) {
                case 0:
                    nextVC = [[CaculatorController alloc] init];
                    break;
                case 1:
                    nextVC = [[LocalizedViewController alloc] init];
                    break;
                case 2:
                    nextVC = [[PartViewController alloc] init];
                    break;
                case 3:
                    nextVC = [[ChannelController alloc] init];
                    break;
                default:
                    return [RACSignal empty];
                    break;
            }
            [self.navigationController pushViewController:nextVC animated:YES];
            return [RACSignal empty];
        }];
        [self.stackView addArrangedSubview:menuBtn];
    }];
    
}


# pragma mark - Getter & Setter

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
        _stackView.backgroundColor = UIColor.lightGrayColor;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 40.f;
    }
    return _stackView;
}
- (NSTimeInterval)lastTimeStamp {
    if (!_lastTimeStamp) {
        _lastTimeStamp = [NSDate date].timeIntervalSince1970 * 1000;
    }
    return _lastTimeStamp;
}

@end
