//
//  LocalDataTableViewController.m
//  UI
//
//  Created by gshopper on 2019/5/15.
//  Copyright © 2019 mozihen. All rights reserved.
//
// TableView Cell  嵌套 CollectionView Cell自适应高度。
// 1. 采用UITableViewAutomaticDimension设定TableView Cell高度。
// 2. AutoLayout布局 Cell，额外设置CollectionView的高度约束。
// 3. 监听CollectionView的ContentSize属性并更新高度约束。




#import "LocalDataTableViewController.h"
#import <objc/runtime.h>
#import <KafkaRefresh/KafkaRefresh.h>
#import "LocalCell.h"

@interface LocalDataTableViewController ()

@property (nonatomic, copy) NSMutableArray *dataArray;

@end

@implementation LocalDataTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}

#pragma mark - UI
- (void)setupUI {
    [self.tableView registerNib: [UINib nibWithNibName:NSStringFromClass(LocalCell.class) bundle:nil]  forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
}

- (void)configDeleteButton:(UIButton *)deleteButton{
    if (deleteButton){
        [deleteButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [deleteButton setTitle:@"" forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"garbage"] forState:UIControlStateNormal];
        [deleteButton setBackgroundColor:[UIColor colorWithRGB:0xd0021b]];
    }
}

#pragma mark - loadData
- (void)loadData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < SHRT_MAX; ++i) {
            ;
        }
        for (NSInteger i = self.dataArray.count + 1; i < 40; ++i) {
            NSMutableArray *array = [NSMutableArray array];
            for (NSInteger j = 1; j < 20; ++j) {
                [array addObject:@{
                                            @"title": @(i * 10 + j).stringValue,
                                            @"check": @(NO)
                                            }];
            }
            [self.dataArray addObject:array];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = @(indexPath.row).stringValue;
    NSArray *cellDataArray = self.dataArray[indexPath.row];
    DDLogDebug(@"%@ : %@", indexPath, cellDataArray);
    [cell bindSource:cellDataArray];
    cell.updateHeightBlock = ^{
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    };
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self loadData];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - Getter
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
