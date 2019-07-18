//
//  ViewController.m
//  UI
//
//  Created by mozihen on 2019/4/17.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"
#import "TableViewController.h"
#import "ButtonViewController.h"
#import "CGDrawViewController.h"
#import "NavigationItemController.h"
#import "CustomizedKeyBoardController.h"
#import "LoginViewController.h"
#import "GestureRecognizeViewController.h"
#import <ASDK/ASDK.h>
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *uiArray;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}
#pragma mark - UI
- (void)setupUI {
    self.title = @"首页";
    [self tableView];
    self.tableView.allowsSelection = YES;
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(pushToLogin:)];
    self.navigationItem.leftBarButtonItem = loginButton;
}
- (void)loadData {
    [self uiArray];
    [self.tableView reloadData];
}
#pragma mark - Actions
- (void)pushToLogin: (UIBarButtonItem *)sender {
    [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
}


#pragma mark - TableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.uiArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = self.uiArray[indexPath.row][@"name"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *nextController = [[self.uiArray[indexPath.row][@"target"] alloc] init];
    [self.navigationController pushViewController:nextController animated:YES];
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_tableView setRowHeight:44.f];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (NSArray *)uiArray {
    if (!_uiArray) {
        _uiArray = @[@{@"name": @"UIImageView", @"target": ImageViewController.class},
                     @{@"name": @"UITableView", @"target": TableViewController.class},
                     @{@"name": @"Button & Image", @"target": ButtonViewController.class},
                     @{@"name": @"图形绘制", @"target": CGDrawViewController.class},
                     @{@"name": @"NavigationItem", @"target": NavigationItemController.class},
                     @{@"name": @"自定义键盘", @"target": CustomizedKeyBoardController.class},
                     @{@"name": @"手势", @"target": GestureRecognizeViewController.class}];
    }
    return  _uiArray;
}

@end
