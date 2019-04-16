//
//  DataViewController.m
//  RecycleReference
//
//  Created by mozihen on 2019/4/15.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "DataViewController.h"
#import "DataUpdateOperation.h"

@interface DataViewController ()

@property (nonatomic, strong) DataUpdateOperation *updateOp;
@property (nonatomic, assign) BOOL refreshing;


@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.randomColor;
}
#pragma mark - Actions
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)refreshAction:(id)sender {
    NSLog(@"%s [enter]", __PRETTY_FUNCTION__);
    if (self.refreshing == NO) {
        self.refreshing  = YES;
        self.updateOp = [DataUpdateOperation new];
        [self.updateOp startWithDelegate:self withSelector:@selector(onDataAvailable:)];
    }
    NSLog(@"%s [exit]", __PRETTY_FUNCTION__);
}

// 刷新数据
- (void)onDataAvailable: (NSArray *)records {
    self.refreshing = NO;
    self.updateOp = nil;
}

#pragma mark - Getter
- (DataUpdateOperation *)updateOp {
    if (!_updateOp) {
        _updateOp = [DataUpdateOperation new];
    }
    return _updateOp;
}


@end
