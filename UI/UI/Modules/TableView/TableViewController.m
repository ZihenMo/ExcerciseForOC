//
//  TableViewController.m
//  UI
//
//  Created by mozihen on 2019/4/22.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "TableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "Person.h"
#import "PersonCell.h"
#import "LocalDataTableViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray *personList;
@property (nonatomic, strong) NSArray <NSString *> *sectionIndexes;

@property (nonatomic, assign) BOOL isAllSelected;   // 全选与取消
@property (nonatomic, copy) NSMutableArray *needDeleteIndexPaths;



@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self requestAllData];
}

#pragma mark - UI
- (void)setupUI {
    /*
     自动根据约束计算行高，自iOS 8之后支持。
     注意：
     图片设置比例后还需要一个确定的高度（如4:3，那么宽高至少设置一项来确定高的值）。
     label可以由文本内容自动填充。
     */
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    // 设置行高为自动计算(约束)
    //    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 设置估算高度
    self.tableView.estimatedRowHeight = 100.f;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.allowsMultipleSelection = YES;
    [self setupNavigationItem];
}

- (void)setupNavigationItem {
    UIBarButtonItem *editingBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(enterEditingAction:)];
    
    self.navigationItem.rightBarButtonItems = @[editingBtnItem];
    UIBarButtonItem *localBtn = [[UIBarButtonItem alloc] initWithTitle:@"加载本地数据" style:UIBarButtonItemStyleDone target:self action:@selector(localBtnAction:)];
    self.navigationItem.leftBarButtonItems = @[localBtn];
    self.navigationItem.leftItemsSupplementBackButton = YES;
}

#pragma mark - Actions
- (void)backAction: (id) sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)localBtnAction: (UIBarButtonItem *)sender {
    LocalDataTableViewController *localVC = [[LocalDataTableViewController alloc] init];

    [self.navigationController pushViewController:localVC animated:YES];
}
- (void)enterEditingAction: (UIBarButtonItem *)sender {
    self.tableView.editing = !self.tableView.editing;
    NSArray *rightBtnItems = self.navigationItem.rightBarButtonItems;
    if (rightBtnItems.count < 3) {
        UIBarButtonItem *deleteBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteAllAction:)];
        UIBarButtonItem *selectAllBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(selectAllAction:)];
        
        self.navigationItem.rightBarButtonItems = [rightBtnItems arrayByAddingObjectsFromArray:@[selectAllBtnItem, deleteBtnItem]];
    }
}

- (void)deleteAllAction: (UIBarButtonItem *)sender {
//    NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:self.needDeleteIndexPaths];
    [self.needDeleteIndexPaths sortUsingComparator:^NSComparisonResult(NSIndexPath *indexPath1, NSIndexPath *indexPath2) {
        if (indexPath1.section == indexPath2.section ){
            return indexPath1.row < indexPath2.row;
        }
        else {
            return indexPath1.section < indexPath2.section;
        }
    }];
    NSMutableArray *needDeleteSections = [NSMutableArray array];
    for (NSIndexPath *indexPath in self.needDeleteIndexPaths) {
        NSMutableArray *personList = self.personList[indexPath.section][@"personList"];
        [personList removeObjectAtIndex:indexPath.row];
        if (personList.count == 0) {
            [self.personList removeObjectAtIndex:indexPath.section];
            [needDeleteSections addObject:@(indexPath.section)];
        }
    }
    [self.tableView reloadData];
    [self.needDeleteIndexPaths removeAllObjects];
}
// 全选与取消
- (void)selectAllAction: (UIBarButtonItem *)sender {
    self.isAllSelected = !self.isAllSelected;
    sender.title = self.isAllSelected ? @"取消" : @"全选" ;
    for (NSInteger i = 0; i < self.personList.count; ++i) {
        for (NSInteger j = 0; j < [self.personList[i][@"personList"] count]; ++j) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            if (self.isAllSelected) {
                [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                [self.needDeleteIndexPaths addObject:indexPath];
            }
            else {
                [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
                [self.needDeleteIndexPaths removeObject:indexPath];
            }
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //    return 1;
    return self.personList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.personList) {
        return [self.personList[section][@"personList"] count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Person *person = self.personList[indexPath.section][@"personList"][indexPath.row];
    [cell bindSource:person];
    return cell;
}

#pragma mark - TableView SectionIndex
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexes;
}
// 组索引映射或替换
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    return index;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
    view.textLabel.text = self.sectionIndexes[section];
    return view;
}

#pragma mark - TableView Editing
// 支持（左滑）编辑的行
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return  indexPath.row != 0;
    return YES;
}

// 响应左滑删除功能
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 先删除数据，再移除UI。不按顺序处理会报异常
        [self.personList[indexPath.section][@"personList"] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
// 删除标题
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
// 左滑出现的按钮与操作
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *actions = [NSMutableArray array];
    UITableViewRowAction *addAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"添加" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        Person *pData = self.personList[indexPath.section][@"personList"][indexPath.row];
        [self.personList[indexPath.section][@"personList"] addObject:pData];
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    [actions addObject:addAction];
    return actions;
}

/// -- 多行编辑 --



/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.needDeleteIndexPaths containsObject:indexPath]) {
        [self.needDeleteIndexPaths removeObject:indexPath];
    }
    else {
        [self.needDeleteIndexPaths addObject:indexPath];
    }
}
#pragma mark - Request

/**
 添加对应组索引（姓）的数据
 
 @param index 当前数据在未分组的索引
 @param personList 组索引对应的数据列表
 @param section 组数据
 @param sectionIndex 组索引
 */
- (void)extracted:(NSUInteger)index personList:(NSArray *)personList section:(id _Nonnull)section sectionIndex:(NSString *)sectionIndex {
    if ([section[@"sectionIndex"] isEqualToString:sectionIndex]) {
        NSMutableArray *sectionPersonList = section[@"personList"];
        if (sectionPersonList == nil) {
            sectionPersonList = [NSMutableArray array];
        }
        [sectionPersonList addObject:personList[index]];
    }
}

/**
 分组处理数据
 
 @param personList 未分组数据
 */
- (void)disposePersonList:(NSArray *)personList {
    NSMutableArray *groupingPerson = [NSMutableArray array];
    [[personList valueForKey:@"nickName"] enumerateObjectsUsingBlock:^(NSString *  _Nonnull nickName, NSUInteger index, BOOL * _Nonnull stop) {
        NSString *sectionIndex = [nickName substringToIndex:1];
        NSArray *sectionIdexes = [groupingPerson valueForKey:@"sectionIndex"];
        if ([sectionIdexes containsObject:sectionIndex]) {
            [groupingPerson enumerateObjectsUsingBlock:^(id  _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
                [self extracted:index personList:personList section:section sectionIndex:sectionIndex];
            }];
        }
        else {
            [groupingPerson addObject:@{@"sectionIndex": sectionIndex,
                                        @"personList": @[personList[index]].mutableCopy
                                        }];
        }
    }];
    self.personList = groupingPerson;
}

- (void)requestAllData {
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/login"];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 15.f;
    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;\
    request.HTTPMethod = @"GET";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error && data) {
            NSLog(@"💖Response:-------------S--------------💖");
            NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil]);
            NSLog(@"💖Response:-------------E--------------💖");
            // 字典数组转模型数组
            // 设置特殊映射键
            [Person mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         @"desc": @"description"
                         };
            }];
            NSArray *personList = [Person mj_objectArrayWithKeyValuesArray:data];
            //             按姓分组处理 @[@{@"sectionIndex:" @"张",
            //                                        @"personList":@[]}]
            [self disposePersonList:personList];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        else {
            NSLog(@"‼️Error:-----------S----------‼️");
            NSLog(@"%@", error.localizedDescription);
            NSLog(@"‼️Error:-----------E----------‼️");
        }
    }];
    NSLog(@"💕Request:-------------S--------------💕");
    NSLog(@"URL: %@", request.URL);
    NSLog(@"💕Request:-------------E--------------💕");
    [task resume];
}

#pragma mark - Getter
- (NSArray<NSString *> *)sectionIndexes {
    if (_sectionIndexes == nil && _personList != nil) {
        _sectionIndexes = [_personList valueForKey:@"sectionIndex"];
    }
    return _sectionIndexes;
}

- (NSMutableArray *)needDeleteIndexPaths {
    if (_needDeleteIndexPaths == nil) {
        _needDeleteIndexPaths = [NSMutableArray array];
    }
    return _needDeleteIndexPaths;
}

@end
