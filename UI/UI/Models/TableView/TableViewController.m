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

@interface TableViewController ()

@property (nonatomic, strong) NSArray *personList;
@property (nonatomic, strong) NSArray <NSString *> *sectionIndexes;



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


/*
 
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

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

@end
