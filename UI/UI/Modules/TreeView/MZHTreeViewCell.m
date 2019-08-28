//
//  MZHTreeViewCell.m
//  UI
//
//  Created by gshopper on 2019/10/28.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "MZHTreeViewCell.h"
#import "MZHTreeNode.h"
@interface MZHTreeViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation MZHTreeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _indentWidth = 20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)bindSouce:(id<MZHTreeNode>)source {
//    self.titleLabel.text = [source title];
    CGRect titleFrame = self.titleLabel.frame;
    CGFloat titleX = self.indentWidth * source.level;
    NSAssert(titleX >= self.width - self.indentWidth, @"缩进大于屏宽");
    titleFrame.origin.x = titleX;
}
#pragma mark - Propety


@end
