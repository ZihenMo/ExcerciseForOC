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
    NSArray *menus = @[@"计算器(手动实现链式)", @"切换本地化语言"];
    [self addMenus: menus];
    [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
    
}

- (NSString *)localize: (NSString *)key {
    NSString *bundlePath = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]];
    NSLog(@"bundlePath: %@", bundlePath);
    NSString *path = [[NSBundle mainBundle] pathForResource: bundlePath ofType:@"lproj"];
    NSLog(@"path = %@", path);
    
    NSString *result =  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:nil];
    return result;
}

- (void)addMenus: (NSArray<NSString *> *)menus {
    [menus enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BaseButton *menuBtn = [BaseButton buttonWithType:UIButtonTypeSystem];
        [menuBtn setTitle:[self localize:@"switch_language"] forState:UIControlStateNormal];
        menuBtn.tag = idx;
        menuBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            switch (menuBtn.tag) {
                case 0:
                    [self showCaculator];
                    break;
                case 1:
                    [self showLocalized];
//                    menuBtn.selected = !menuBtn.selected;
//                    NSLog(@"%@", [self localize:@"switch_language"]);
//                    if (menuBtn.selected) {
//                        [[NSUserDefaults standardUserDefaults] setObject:@"zh-HK" forKey:@"appLanguage"];
//                    }
//                    else {
//                        [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
//                    }
                default:
                    break;
            }
            return [RACSignal empty];
        }];
        [self.stackView addArrangedSubview:menuBtn];
    }];
    
}

# pragma mark - Actions
- (void)showCaculator {
    CaculatorController *caculatorController = [[CaculatorController alloc] init];
    [self presentViewController:caculatorController animated:YES completion:nil];
}
- (void)showLocalized {
    LocalizedViewController *localeController = [[LocalizedViewController alloc] init];
    [self presentViewController:localeController animated:YES completion:nil];
}
- (void)setLocal {
    NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    // 1. 获取所有系统语言列表
    [NSLocale availableLocaleIdentifiers];
    
    
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
