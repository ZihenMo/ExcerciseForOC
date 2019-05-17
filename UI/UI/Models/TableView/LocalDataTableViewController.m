//
//  LocalDataTableViewController.m
//  UI
//
//  Created by gshopper on 2019/5/15.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "LocalDataTableViewController.h"

@interface LocalDataTableViewController ()

@property (nonatomic, copy) NSMutableArray *dataArray;

@end

@implementation LocalDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}


/**
 懒加载View
    改变默认view(tableView)。
 */
- (void)loadView {
    UIView *view = [UIView new];
    view.backgroundColor = UIColor.randomColor;
    self.view = view;
}

#pragma mark - UI
- (void)setupUI {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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
    for (NSInteger i = 1; i < 40; ++i) {
        [self.dataArray addObject:@(i)];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.dataArray[indexPath.row] stringValue];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}
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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

#pragma mark - Getter
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
