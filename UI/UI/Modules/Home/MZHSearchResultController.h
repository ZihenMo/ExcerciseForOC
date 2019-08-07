//
//  MZHSearchResultController.h
//  UI
//
//  Created by gshopper on 2019/7/31.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "MZHViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MZHBlurSearchBlock)(void);
@interface MZHSearchResultController : MZHViewController <UISearchResultsUpdating>


/**
 搜索结果数据
 @[@{name:xxx, target: UIViewController.class}]
 */
@property (nonatomic, copy) NSArray *resultArray;
@property (nonatomic, copy) MZHBlurSearchBlock blurBlock;
@property (nonatomic, strong) UINavigationController *searchNavigationController;
@property (nonatomic, strong) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
