//
//  ViewController.m
//  RAC
//
//  Created by mozihen on 2019/4/2.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "ViewController.h"
#import "CaculatorController.h"
#import "LocalizedViewController.h"
#import "PartViewController.h"

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
    // -- stackView --
    [self.view addSubview:self.stackView];
    [self.stackView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(self.view).multipliedBy(0.618);
    }];
    // -- add menus --
    NSArray *menus = @[@"计算器(手动实现链式)", @"切换本地化语言", @"局部变量RAC"];
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
                default:
                    return [RACSignal empty];
                    break;
            }
            [self presentViewController:nextVC animated:YES completion:nil];
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

@end
