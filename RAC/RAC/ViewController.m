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
- (IBAction)switchLanguageAction:(UIButton *)sender {
}
- (IBAction)ssss:(id)sender {
}

- (IBAction)switchLanguage:(UIButton *)sender {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // 实现转换首字线大写
    // 1. 创建源序列
    RACSequence *sequence = @[@"what", @"are", @"the", @"fuck", @"thing"].rac_sequence;
    // 2. 获取序列信号量
    RACSignal *signal = sequence.signal;
    // 3. 生成首字线大写的信号量
    RACSignal *capitalizedSignal = [signal map:^id _Nullable(NSString *value) {
        return [value capitalizedString];
    }];
    // 4. 订阅信号量(新的信号与原信号互不影响）
    // 4.1 序列信号量订阅时，按序触发
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    // 4.2 首字母大写信号量
    [capitalizedSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
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
    NSArray *menus = @[t1, @"切换本地化语言", @"局部变量RAC"];
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

@end
