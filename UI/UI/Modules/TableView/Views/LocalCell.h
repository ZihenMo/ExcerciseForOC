//
//  LocalCell.h
//  UI
//
//  Created by gshopper on 2019/7/29.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef dispatch_block_t UpdateHeightBlock;
@interface LocalCell : UITableViewCell

@property (weak, nonatomic) IBOutlet BaseLabel *titleLabel;
@property (nonatomic, copy) UpdateHeightBlock updateHeightBlock;

- (void)bindSource: (NSArray *)source;

@end

NS_ASSUME_NONNULL_END
