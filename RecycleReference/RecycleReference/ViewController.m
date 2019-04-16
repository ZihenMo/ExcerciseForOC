//
//  ViewController.m
//  RecycleReference
//
//  Created by mozihen on 2019/4/15.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "ViewController.h"
#import "DataViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    DataViewController *nextVC = [[DataViewController alloc] init];
//    [self presentViewController:nextVC animated:YES completion:nil];
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DataViewController *nextVC = [[DataViewController alloc] init];
        [self presentViewController:nextVC animated:YES completion:nil];
    
}
@end
