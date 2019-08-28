//
//  PersonCell.m
//  UI
//
//  Created by mozihen on 2019/5/4.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "PersonCell.h"
#import "GRPerson.h"
#import "MZShadowRadiusView.h"

class CPPClass {
public:
    void cppFunc(const char *);
};
void CPPClass::cppFunc(const char *arg) {
    NSLog(@"cpp func: %s", arg);
}
extern "C" void shortCFunc(const char *arg) {
    CPPClass cpp;
    cpp.cppFunc(arg);
}
@interface PersonCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (weak, nonatomic) IBOutlet MZShadowRadiusView *wrapView;

@end

@implementation PersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CPPClass cpp;
    cpp.cppFunc("This is a cpp function!");
}
- (void)prepareForReuse {
    [super prepareForReuse];
//    [self.wrapView setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)bindSource:(GRPerson *)person {
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString: person.avatar]];
    self.nickNameLbl.text = person.nickName;
    self.descriptionLbl.text = person.desc;
    self.emailLbl.text = person.email;
    
}

@end

