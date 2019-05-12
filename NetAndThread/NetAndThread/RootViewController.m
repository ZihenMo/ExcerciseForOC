//
//  RootViewController.m
//  NetAndThread
//
//  Created by mozihen on 2019/5/12.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "RootViewController.h"
#import "ThreadViewController.h"

@interface RootViewController ()

@property (nonatomic, copy) NSMutableArray *subjectArray;

@end
NSString *kCellId = @"cell";
@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}
#pragma mark - UI
- (void)setupUI {
    
}
#pragma mark - load
- (void)loadData {
    NSArray *subjects = @[@"pthread & NSThread", @"GCD", @"NSOperation", @"RunLoop"];
    [self.subjectArray addObjectsFromArray:subjects];
     [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.subjectArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    cell.backgroundColor = UIColor.randomColor;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.subjectArray[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *nextController;
    switch (indexPath.section) {
        case 0:
            nextController = [[ThreadViewController alloc] init];
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:nextController animated:YES];
}

#pragma mark - Getter
- (NSMutableArray *)subjectArray {
    if (_subjectArray == nil) {
        _subjectArray = [NSMutableArray array];
    }
    return _subjectArray;
}

@end
