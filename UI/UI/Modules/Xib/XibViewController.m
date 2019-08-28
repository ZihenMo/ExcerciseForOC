//
//  XibViewController.m
//  UI
//
//  Created by gshopper on 2019/8/7.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "XibViewController.h"
#import "MZHQuantityView.h"
#import "MZHMenuView.h"

@interface XibViewController ()

@end

@implementation XibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    MZHQuantityView *customizedView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(MZHQuantityView.class) owner:nil options:nil]lastObject];
    
    customizedView.frame = CGRectMake(100, 200, 120, 50);
    customizedView.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:customizedView];
    
    MZHMenuView *menuView = [[MZHMenuView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 50)];
    DDLogDebug(@"menuFrame: %@", NSStringFromCGRect(menuView.frame));
    DDLogDebug(@"viewFrmae: %@", NSStringFromCGRect(self.view.frame));
    menuView.menus = @[@"所有", @"普通标题", @"特别长长长长长长长长的标题出现了"];
    [self.view addSubview:menuView];
}



@end
