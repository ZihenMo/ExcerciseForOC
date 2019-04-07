//
//  PartViewController.m
//  RAC
//
//  Created by mozihen on 2019/4/7.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "PartViewController.h"
#import "BaseLabel.h"

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,assign) CGSize body;




@end

@implementation Person

@end


@interface PartViewController ()

@end

@implementation PartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    self.view.backgroundColor = UIColor.whiteColor;
    UITextField *tf = [[UITextField alloc] init];
    tf.backgroundColor = UIColor.randomColor;
    tf.textColor = UIColor.whiteColor;
    [self.view addSubview:tf];
    [tf makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-50);
        make.size.equalTo(@(CGSizeMake(200, 40)));
    }];
     BaseLabel *lbl = [[BaseLabel alloc] init];
    [self.view addSubview:lbl];
    [lbl makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    [tf.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        lbl.text = x;
    }];
    [RACObserve(lbl, text) subscribeNext:^(id  _Nullable x) {
        NSLog(@"---lbl signal is %@---", x);
        NSLog(@"intrinsic: %@", NSStringFromCGSize(lbl.intrinsicContentSize));
    }];
    [RACObserve(lbl, intrinsicContentSize) subscribeNext:^(id  _Nullable x) {
        NSLog(@"---lbl intrinsic signal is %@---", x);
    }];
    
    
    // --- RAC监听局部变量
    Person *p = [Person new];
    p.name = @"name1";
    p.age = 1;
    p.body = CGSizeMake(1, 1);
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        p.name = [NSString stringWithFormat:@"name%ld", p.age+1];
        p.age += 1;
        p.body = CGSizeMake(p.age, p.age);
        p.age >= 3 ? [timer invalidate] : nil;
    }];
    [RACObserve(p,name) subscribeNext:^(id  _Nullable x) {
        NSLog(@"----name: %@", x);
    }];
    [RACObserve(p, age) subscribeNext:^(id  _Nullable x) {
        NSLog(@"---age: %@", x);
    }];
    [RACObserve(p, body) subscribeNext:^(id  _Nullable x) {
        NSLog(@"---body: %@", x);
    }];
    // --- 结论：成功 --
    
    
    [lbl addObserver:self forKeyPath:@"intrinsicContentSize" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"---change is %@", change);
}



@end
