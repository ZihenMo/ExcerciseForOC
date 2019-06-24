//
//  NavigationItemController.m
//  UI
//
//  Created by gshopper on 2019/5/16.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "NavigationItemController.h"

@interface NavigationItemController ()

@end

@implementation NavigationItemController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    self.title = @"导航栏相关";
}
#pragma mark - Action

/**
 隐藏或显示系统返回按钮
 */
- (IBAction)supportOrHideBackBtnItemAction:(BaseButton *)sender {
    sender.selected = !sender.selected;
    self.navigationItem.leftItemsSupplementBackButton = !sender.selected;
    self.navigationItem.hidesBackButton = sender.selected;
}
/**
 显示返回按钮的标题为“返回”
 */
- (IBAction)showBackTitleAction:(BaseButton *)sender {
    sender.selected = !sender.selected;
    NSString *title = sender.selected ? @"返回" : @"";
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBtnItem;
    // 设置返回标题文字后，push到下一个视图控制器才生效
//    UIViewController *nextVC = [UIViewController new];
//    [self.navigationController pushViewController:nextVC animated:YES];
}

/**
 添加左边自定义按钮
 */
- (IBAction)addLeftBarBtnItemAction:(BaseButton *)sender {
    NSInteger index = self.navigationItem.leftBarButtonItems.count;
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"左边%ld", index] style:UIBarButtonItemStylePlain target:nil action:nil];
    if (index < 3) {
        NSMutableArray *leftBtnItems = [NSMutableArray array];
        [leftBtnItems addObjectsFromArray: self.navigationItem.leftBarButtonItems];
        [leftBtnItems addObject:leftBtn];
        self.navigationItem.leftBarButtonItems = leftBtnItems;
    }
}

/**
 添加右边自定义按钮
 */
- (IBAction)addRightBarBtnItemAction:(BaseButton *)sender {
    NSInteger index = self.navigationItem.rightBarButtonItems.count;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"右边%ld", index] style:UIBarButtonItemStylePlain target:nil action:nil];
    if (index < 3) {
        NSMutableArray *rightBtnItems = [NSMutableArray array];
        [rightBtnItems addObjectsFromArray:self.navigationItem.rightBarButtonItems];
        [rightBtnItems addObject:rightBtn];
        self.navigationItem.rightBarButtonItems = rightBtnItems;
    }
}

/**
 自定义返回图标
 */
- (IBAction)replaceBackIcon:(BaseButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
//        UIImage *backIndicatorImage = self.navigationController.navigationBar.backIndicatorImage;
//        UIImage *backIndicatorTransitionMaskImage = self.navigationController.navigationBar.backIndicatorTransitionMaskImage;
        [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"timg"]];
        [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"timg"]];
    }
    else {
        [self.navigationController.navigationBar setBackIndicatorImage:nil];
        [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:nil];
    }
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBtnItem;
}




@end
