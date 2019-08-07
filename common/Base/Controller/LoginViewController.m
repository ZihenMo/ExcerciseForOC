//
//  LoginViewController.m
//  UI
//
//  Created by gshopper on 2019/6/27.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "LoginViewController.h"
#import "DynamicInputView.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet DynamicInputView *userNameInputView;
@property (weak, nonatomic) IBOutlet DynamicInputView *passwordInputView;
@property (weak, nonatomic) IBOutlet BaseButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameInputView.placeholder = @"用户名";
    self.passwordInputView.placeholder = @"密码";
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    self.loginButton.backgroundColor = [UIColor colorWithRGB:0x59ACAC];
    [self.loginButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.passwordInputView.type = DynamicInputTypeSecurity;
}
#pragma mark - Action

- (IBAction)loginAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
