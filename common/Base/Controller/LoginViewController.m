//
//  LoginViewController.m
//  UI
//
//  Created by gshopper on 2019/6/27.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "LoginViewController.h"
#import "DynamicInputView.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface LoginViewController ()<GIDSignInDelegate>
@property (weak, nonatomic) IBOutlet DynamicInputView *userNameInputView;
@property (weak, nonatomic) IBOutlet DynamicInputView *passwordInputView;
@property (weak, nonatomic) IBOutlet BaseButton *loginButton;
@property(weak, nonatomic) IBOutlet UIButton *signInButton;

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
    [GIDSignIn sharedInstance].delegate = self;
}
#pragma mark - Action

- (IBAction)logOutAction: (UIButton *)sender {
    [[GIDSignIn sharedInstance] signOut];
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
}

- (IBAction)loginAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginWithGoogle:(id)sender {
    [[GIDSignIn sharedInstance] signIn];
    NSLog(@"--cur user--: %@", [GIDSignIn sharedInstance].currentUser);
}
- (IBAction)loginWithFaceBook:(id)sender {
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    loginManager.loginBehavior = FBSDKLoginBehaviorBrowser;
    
    [loginManager logInWithPermissions: @[@"public_profile",@"email",@"user_friends"]fromViewController:self handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            DDLogDebug(@"--- FaceBook Login Error: %@", error);
        } else if (result.isCancelled) {
            DDLogDebug(@"--- FaceBook Cancel Login ---");
        } else {
            DDLogDebug(@"--- FaceBook Logined ---");
            DDLogDebug(@"result: %@", result);
            [FBSDKProfile loadCurrentProfileWithCompletion:^(FBSDKProfile * _Nullable profile, NSError * _Nullable error) {
                DDLogDebug(@"--- FBName: %@", profile.name);
                DDLogDebug(@"--- UserId: %@", profile.userID);
                DDLogDebug(@"--- AccessToken: %@", [FBSDKAccessToken currentAccessToken].tokenString);
            }];
        }
    }];
}
#pragma mark - Google Delegate

/**
 登录Google
 */
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error != nil) {
        if (error.code == kGIDSignInErrorCodeHasNoAuthInKeychain) {
            NSLog(@"The user has not signed in before or they have since signed out.");
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        return;
    }
    // Perform any operations on signed in user here.
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *fullName = user.profile.name;
    NSString *givenName = user.profile.givenName;
    NSString *familyName = user.profile.familyName;
    NSString *email = user.profile.email;
    // ...
    NSLog(@"Google User: %@", user);
}

/**
 Google断开连接
 */
- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    NSLog(@"Google disconnect user: %@", user);
}
@end
