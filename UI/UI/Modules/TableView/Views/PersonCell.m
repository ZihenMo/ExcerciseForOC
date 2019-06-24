//
//  PersonCell.m
//  UI
//
//  Created by mozihen on 2019/5/4.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "PersonCell.h"
#import "Person.h"


@interface PersonCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;

@end

@implementation PersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)bindSource:(Person *)person {
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString: person.avatar]];
    self.nickNameLbl.text = person.nickName;
    self.descriptionLbl.text = person.desc;
    self.emailLbl.text = person.email;
    
}

@end
