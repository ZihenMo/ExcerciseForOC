//
//  ChannelCell.m
//  SendbirdChat
//
//  Created by mozihen on 2019/6/23.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "ChannelCell.h"

@interface ChannelCell ()
@property (nonatomic, weak) IBOutlet UIImageView *coverImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@end

@implementation ChannelCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)bindData:(NSDictionary *) data {
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:data[@"coverUrl"]]];
    self.titleLabel.text = data[@"title"];
}
@end
