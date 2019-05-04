//
//  ViewController.m
//  UI
//
//  Created by mozihen on 2019/4/17.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"
#import "ButtonViewController.h"

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
    [self tableView];
}
- (void)loadData {
    [self uiArray];
    [self.tableView reloadData];
}

#pragma mark - TableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.uiArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = self.uiArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *nextController;
    switch (indexPath.row) {
        case 0:
            nextController = [[ImageViewController alloc] init];
            break;
        case 1:
            nextController = [[ButtonViewController alloc] init];
        default:
            break;
    }
    [self presentViewController:nextController animated:YES completion:nil];
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
        _uiArray = @[@"UIImageView", @"UIButton", @"UITableView"];
    }
    return  _uiArray;
}

@end