//
//  LocalizedViewController.m
//  RAC
//
//  Created by gshopper on 2019/4/2.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "LocalizedViewController.h"

@interface LocalizedViewController ()

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
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showAllLcaleList {
    NSArray *idList = [NSLocale availableLocaleIdentifiers];
    for (NSString *localeId in idList) {
        NSLog(localeId);
    }
}

@end
