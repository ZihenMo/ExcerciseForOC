//
//  MZHSearchResultController.m
//  UI
//
//  Created by gshopper on 2019/7/31.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "MZHSearchResultController.h"

static NSString *const kCellId = @"Result Cell Id";

@interface MZHSearchResultController ()<UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate>

@property (nonatomic, copy) NSArray *searchResults;

@end

@implementation MZHSearchResultController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

#pragma mark - TableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    NSDictionary *dataDict = self.searchResults[indexPath.row];
    if (dataDict) {
        cell.textLabel.text = dataDict[@"name"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dataDict = self.searchResults[indexPath.row];
    UIViewController *targetController;
    if (dataDict) {
        Class targetClass = dataDict[@"target"];
        targetController = [[targetClass alloc] init];
    }
    if (targetController) {
        if (self.navigationController) {
            [self.navigationController pushViewController:targetController animated:NO];
        }
        else if (self.searchNavigationController) {
            [self.searchNavigationController pushViewController:targetController animated:NO];
            if (self.blurBlock) {
                self.blurBlock();
            }
        }
        else {
            [self presentViewController:targetController animated:NO completion:nil];
        }
    }
}
#pragma mark - UISearchResultUpdating
- (void)updateSearchResultsForSearchController:(UISearchController*)searchController {
    NSString *searchText = searchController.searchBar.text;
    DDLogDebug(@"--- Search Text: %@ ---", searchText);
    if (searchText) {
        NSArray *searchResults = [self.resultArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            NSString *name = [evaluatedObject[@"name"] lowercaseString];
            return [name containsString:[searchText lowercaseString]];
        }]];
        self.searchResults = searchResults;
        [self.tableView reloadData];
    }
    searchController.searchResultsController.view.hidden = NO; // 解决首次不显示结果面板问题
}

#pragma mark - UISearchController Delegate


#pragma mark - Getter & Setter

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 55.f;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kCellId];
    }
    return _tableView;
}

- (void)setResultArray:(NSArray *)resultArray {
    _resultArray = resultArray.copy;
    self.searchResults = _resultArray;
}
@end
