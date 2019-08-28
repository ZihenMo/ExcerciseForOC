//
//  MZHTreeViewCell.h
//  UI
//
//  Created by gshopper on 2019/10/28.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MZHTreeNode;
@interface MZHTreeViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat indentWidth;
@property (nonatomic, assign) BOOL indentDisable;


- (void)bindSouce: (id <MZHTreeNode>)source;

@end

NS_ASSUME_NONNULL_END
