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
    [self signalSwitch];
    [self combiningLatest];
    [self merge];
}
#pragma mark - RAC
//信号开关Switch
- (void)signalSwitch {
    //创建3个可接收信号的对象（subject对象用于无RAC链接到RAC，手动发送事件（sendNex)）
    RACSubject *google = [RACSubject subject];
    RACSubject *baidu = [RACSubject subject];
    RACSubject *signalOfSignal = [RACSubject subject];
    
    //获取开关信号
    RACSignal *switchSignal = [signalOfSignal switchToLatest];
    
    //对通过开关的信号进行操作
    [[switchSignal  map:^id(NSString * value) {
        return [@"https//www." stringByAppendingFormat:@"%@", value];
    }] subscribeNext:^(NSString * x) {
        NSLog(@"%@", x);
    }];
    
    
    //通过开关打开baidu
    [signalOfSignal sendNext:baidu];
    [baidu sendNext:@"baidu.com"];
    [google sendNext:@"google.com"];
    NSLog(@"---分割线---");
    //通过开关打开google
    [signalOfSignal sendNext:google];
    [baidu sendNext:@"baidu.com/"];
    [google sendNext:@"google.com/"];
}

//组合信号
- (void)combiningLatest{
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    [[RACSignal
      combineLatest:@[letters, numbers]
      reduce:^(NSString *letter, NSString *number){ // 合并letter与number
          return [letter stringByAppendingString:number];
      }]
     subscribeNext:^(NSString * x) {
         NSLog(@"%@", x);
     }];
    
    //A1 B1 C2    因为numbers的最新信号依旧是1，所以是B1
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
}
//合并信号
- (void)merge {
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSubject *chinese = [RACSubject subject];
    
    [[RACSignal
      merge:@[letters, numbers, chinese]]
     subscribeNext:^(id x) {
         NSLog(@"%@", x);
     }];
    /*
     AAA
     666
     你好！
     */
    [letters sendNext:@"AAA"];
    [numbers sendNext:@"666"];
    [chinese sendNext:@"你好！"];
}


#pragma mark - UI
- (void)setupUI {
    self.view.backgroundColor = UIColor.whiteColor;
    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = @"输入内容，同步显示";
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
}


- (void) obserLocalValue {
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
}


@end
