//
//  LocalizedViewController.m
//  RAC
//
//  Created by gshopper on 2019/4/2.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "LocalizedViewController.h"

@interface LocalizedViewController ()
@property (nonatomic, strong) BaseLabel *textLbl;
@property (nonatomic, strong) NSArray *languages;

@end

@implementation LocalizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

# pragma mark - UI
- (void)setupUI {
    self.view.backgroundColor = UIColor.whiteColor;
    BaseButton *btn = [BaseButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"获取所有本地化列表标识" forState:UIControlStateNormal];
    [btn setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        [self showAllLcaleList];
        return [RACSignal empty];
    }]];
    [self.view addSubview:btn];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).multipliedBy(0.618);
    }];
    
    BaseLabel *textLbl = [[BaseLabel alloc] init];
    textLbl.text = Localized(@"paragraph");
    [self.view addSubview:textLbl];
    [textLbl makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(btn.bottom).offset(50);
    }];
    self.textLbl = textLbl;
    [self setupSwitchButtonGroup];
}

/**
 切换语言按钮组
 */
- (void)setupSwitchButtonGroup {
    UIStackView *switchBtnGroupStack = [[UIStackView alloc] init];
    [self.view addSubview:switchBtnGroupStack];
    switchBtnGroupStack.distribution = UIStackViewDistributionFillEqually;
    switchBtnGroupStack.spacing = 10.f;
    switchBtnGroupStack.axis = UILayoutConstraintAxisVertical;
    [switchBtnGroupStack makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.textLbl.bottom).offset(100);
        make.width.equalTo(@(200));
    }];
    for (NSInteger i = 0; i<self.languages.count; ++i) {
        BaseButton *btn = [BaseButton buttonWithType:UIButtonTypeCustom];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
        }];
        [switchBtnGroupStack addArrangedSubview:btn];
        btn.tag = i;
        [btn setTitle:self.languages[i][@"title"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(switchLanguageAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - Actions
- (void)switchLanguageAction: (UIButton *)btn {
    NSInteger idx = btn.tag;
    [[NSUserDefaults standardUserDefaults] setValue:self.languages[idx][@"file"] forKey:@"appLanguage"];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showAllLcaleList {
    NSArray *idList = [NSLocale availableLocaleIdentifiers];
    for (NSString *localeId in idList) {
        NSLog(@"%@", localeId);
    }
}


/// 测试本地化
- (NSString *)localize: (NSString *)key {
    NSString *bundlePath = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]];
    NSLog(@"bundlePath: %@", bundlePath);
    NSString *path = [[NSBundle mainBundle] pathForResource: bundlePath ofType:@"lproj"];
    NSLog(@"path = %@", path);
    
    NSString *result =  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:nil];
    return result;
}
- (NSArray *)languages {
    if (!_languages) {
        _languages = @[@{@"title": @"中文", @"file": @"zh-Hans"},
                       @{@"title": @"英文", @"file": @"en"}];
    }
    return _languages;
}
@end
