//
//  PersonDetailController.m
//  UI
//
//  Created by gshopper on 2019/9/27.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "PersonDetailController.h"
#import "GRPerson.h"

@interface PersonDetailController ()<UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarIV;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextView *descTV;

@property (nonatomic, assign) BOOL hasChanged;
@property (nonatomic, strong) UIBarButtonItem *saveBI;
@end

@implementation PersonDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    _saveBI = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(savePersonAction:)];
    _saveBI.enabled = NO;
    UIBarButtonItem *backBI = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.rightBarButtonItem = _saveBI;
    self.navigationItem.leftBarButtonItem = backBI;
    self.nickNameTF.delegate = self;
    self.emailTF.delegate = self;
    self.descTV.delegate = self;
    [self updateUI];
}

- (void)updateUI {
    [_avatarIV sd_setImageWithURL:[NSURL URLWithString: self.person.avatar]];
    _nickNameTF.text = self.person.nickName;
    _emailTF.text = self.person.email;
    _descTV.text = self.person.desc;
}

#pragma mark - Action
- (void)backAction: (UIBarButtonItem *)sender {
    if (!_hasChanged) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message: @"保存本次编辑？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAciton = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self savePersonAction:nil];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [alert addAction:okAciton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)savePersonAction: (UIBarButtonItem *)sender {
    self.person.nickName = self.nickNameTF.text;
    self.person.email = self.emailTF.text;
    self.person.desc = self.descTV.text;
    [self.navigationController popViewControllerAnimated:YES];
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}
#pragma mark - TextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (string.length != 0) {
        self.hasChanged = YES;
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (text.length != 0) {
        self.hasChanged = YES;
    }
    return YES;
}

#pragma mark - Setter
- (void)setHasChanged:(BOOL)hasChanged {
    _hasChanged = hasChanged;
    if (hasChanged) {
        self.saveBI.enabled = YES;
    }
}
@end
