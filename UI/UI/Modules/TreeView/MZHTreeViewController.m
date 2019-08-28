//
//  MZHTreeViewController.m
//  UI
//
//  Created by gshopper on 2019/10/28.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "MZHTreeViewController.h"
#import "MZHTreeViewCell.h"
#import "MZHTreeNode.h"

@interface MZHTreeViewController ()

@property (nonatomic, strong) NSMutableArray <MZHTreeNode> *treeNodeList;

@end
static NSString *const kTreeCellId = @"Tree Cell Id";
@implementation MZHTreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI {
    [self.tableView registerClass:MZHTreeViewCell.class forCellReuseIdentifier:kTreeCellId];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.treeNodeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MZHTreeViewCell *treeCell = [tableView dequeueReusableCellWithIdentifier:kTreeCellId];
    id <MZHTreeNode> model = self.treeNodeList[indexPath.row];
    [treeCell bindSouce:model];
    return treeCell;
}

#pragma mark - Property
- (NSMutableArray *)treeNodeList {
    if (_treeNodeList) {
        _treeNodeList = [[self generateTree] mutableCopy];
    }
    return _treeNodeList;
}
- (NSArray *)generateTree {
    NSMutableArray *nodeArray = [NSMutableArray array];
    for (NSInteger j = 0; j < random() % 10 + 1; ++j) {
        MZHTreeNode *node = [self generateTreeNodeWithParentNode:nil andLevel:j];
        [nodeArray addObject:node];
        NSMutableArray *childNodeList = [NSMutableArray array];
        for (NSInteger i = 0; i < random() % 10 + 1; ++i) {
            MZHTreeNode *childNode = [self generateTreeNodeWithParentNode:node andLevel:node.level + 1];
            [childNodeList addObject:childNode];
        }
        node.childNodeList = childNodeList;
    }
    
    return nodeArray;
}

- (MZHTreeNode *)generateTreeNodeWithParentNode: (MZHTreeNode *)parentNode andLevel: (NSInteger)index{
    MZHTreeNode *node = [MZHTreeNode new];
    node.title = [NSString stringWithFormat:@"%ld级节点%ld", parentNode.level + 1, index];
    node.parentNode = parentNode;
    return node;
}

@end
