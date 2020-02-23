//
//  ViewController.m
//  UI
//
//  Created by mozihen on 2019/4/17.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "HomeViewController.h"

#import <ASDK/ASDK.h>
#import <fishhook/fishhook.h>
#import <objc/runtime.h>

#import "ImageViewController.h"
#import "TableViewController.h"
#import "ButtonViewController.h"
#import "CGDrawViewController.h"
#import "NavigationItemController.h"
#import "CustomizedKeyBoardController.h"
#import "LoginViewController.h"
#import "GestureRecognizeViewController.h"
#import "CollectionViewController.h"
#import "BuglyViewController.h"
#import "MZHSearchResultController.h"
#import "XibViewController.h"
#import "XibNestingViewController.h"

#import "MZHQuantityView.h"
#import "PopoverView.h"
#import "UIDevice+Tools.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) MZHSearchResultController *resultController;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation HomeViewController
//函数指针，用来保存原始的函数地址
static void (*origin_nslog)(NSString *format, ...);
void mzh_log(NSString *format, ...) {
    origin_nslog(@"---来了老弟!---");
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    origin_nslog(message);
    va_end(args);
    
}

/**
 方法交换测试1
 */
- (void)fishihookTest {
    NSLog(@"调用一次，保存到懒加载表");
    
    //定义rebinding结构体
    struct rebinding nslogBind;
    //函数的名称
    nslogBind.name = "NSLog";
    //新的函数地址
    nslogBind.replacement = mzh_log;
    //保存原始函数地址变量的指针
    nslogBind.replaced = (void *)&origin_nslog;
    
    //定义数组
    struct rebinding rebs[] = {nslogBind};
    
    /**
     arg1: 存放rebinding结构体的数组
     arg2: 数组的长度
     */
    rebind_symbols(rebs, 1);
}

- (void)checkDevice {
    if ([UIDevice isJailbreak]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"为了您的信息安全，暂不支持越狱设备使用" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAciton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:okAciton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        DDLogDebug(@"正常设备，放心食用");
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
    [self checkDevice];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
#pragma mark - UI
- (void)setupUI {
    self.title = @"首页";
    [self setupSearch];
    [self tableView];
    self.tableView.allowsSelection = YES;
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(pushToLogin:)];
    self.navigationItem.leftBarButtonItem = loginButton;
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStyleDone target:self action:@selector(showMenuAction:)];
    self.navigationItem.rightBarButtonItem = menuButton;
}

/**
 
 设置SearchBar后，通过push的二级页面多一层视图覆盖。（UINavigationControllerPaletteClippingView）
 */
- (void)setupSearch {
    self.definesPresentationContext = YES;
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = self.searchController;
        // 默认展示搜索栏
        self.navigationItem.hidesSearchBarWhenScrolling = NO;
    } else {
        self.navigationItem.titleView = self.searchController.searchBar;
    }
    // iOS 13已经禁该方式，提供了新的属性
    //    UITextField *searchFeild = [self.searchController.searchBar valueForKeyPath:@"_searchField"];
    UITextField *searchFeild = self.searchController.searchBar.searchTextField;
    searchFeild.placeholder = @"搜索";
    searchFeild.textColor = UIColor.orangeColor;
    self.searchController.searchBar.showsCancelButton = YES;
    searchFeild.contentMode = UIViewContentModeCenter;
}

- (void)loadData {
    [self dataArray];
    [self.tableView reloadData];
}

#pragma mark - Actions
- (void)pushToLogin: (UIBarButtonItem *)sender {
    [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
}

- (void)showMenuAction: (UIBarButtonItem *)sender {
    PopoverView *pop = [PopoverView popoverView];
    PopoverAction *qrCodeAction = [PopoverAction actionWithTitle:@"扫描二维码" handler:^(PopoverAction *action) {
        
    }];
    PopoverAction *moneyPacketAction = [PopoverAction actionWithTitle:@"钱包" handler:^(PopoverAction *action) {
        
    }];
    PopoverAction *payAction = [PopoverAction actionWithTitle:@"收付款" handler:^(PopoverAction *action) {
        
    }];
    NSArray *actions = @[qrCodeAction, moneyPacketAction, payAction];
    [pop showToPoint:CGPointMake(UIScreen.mainScreen.bounds.size.width - 30, UIApplication.sharedApplication.statusBarFrame.size.height + 44) withActions:actions];
}

#pragma mark - TableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    NSDictionary *rowDictionary = self.dataArray[indexPath.row];
    if (rowDictionary) {
        cell.textLabel.text = rowDictionary[@"name"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *nextController = [[self.dataArray[indexPath.row][@"target"] alloc] init];
    [self.navigationController pushViewController:nextController animated:YES];
}
#pragma mark - UISearchControllerDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    DDLogDebug(@"--- Search Text: %@ ---", searchText);
    
    if (searchText) {
        NSArray *searchResults = [self.dataArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            NSString *name = [evaluatedObject[@"name"] lowercaseString];
            return [name containsString:[searchText lowercaseString]];
        }]];
        self.resultController.resultArray = searchResults;
        [self.resultController.tableView reloadData];
    }
    searchController.searchResultsController.view.hidden = NO; // 解决首次不显示结果面板问题
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
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@{@"name": @"UIImageView", @"target": ImageViewController.class},
                       @{@"name": @"Button & Image", @"target": ButtonViewController.class},
                       @{@"name": @"UITableView", @"target": TableViewController.class},
                       @{@"name": @"CollecitonView", @"target": CollectionViewController.class},
                       @{@"name": @"NavigationItem", @"target": NavigationItemController.class},
                       @{@"name": @"图形绘制", @"target": CGDrawViewController.class},
                       @{@"name": @"自定义键盘", @"target": CustomizedKeyBoardController.class},
                       @{@"name": @"手势", @"target": GestureRecognizeViewController.class},
                       @{@"name": @"Bugly", @"target": BuglyViewController.class},
                       @{@"name": @"Xib嵌套", @"target": XibNestingViewController.class}
                     ];
    }
    return  _dataArray;
}

- (UISearchController *)searchController {
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultController];
        _searchController.searchResultsUpdater = self;
    }
    return _searchController;
}

- (MZHSearchResultController *)resultController {
    if (_resultController == nil) {
        _resultController = [[MZHSearchResultController alloc] init];
        _resultController.resultArray = self.dataArray;
        _resultController.searchNavigationController = self.navigationController;
        @weakify(self);
        _resultController.blurBlock = ^{
            @strongify(self);
            self.searchController.searchBar.text = nil;
        };
    }
    return _resultController;
}
@end