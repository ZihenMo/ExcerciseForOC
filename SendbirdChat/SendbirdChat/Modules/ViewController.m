//
//  ViewController.m
//  SendbirdChat
//
//  Created by gshopper on 2019/5/23.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "ViewController.h"
#import <SendBirdSDK/SendBirdSDK.h>
#import "ChannelController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation ViewController
#pragma mark - LiftCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.loginBtn.layer.cornerRadius = 4.0;
    self.loginBtn.layer.masksToBounds = YES;
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:SendBirdUserId];
    if (userId.isEmpty == NO) {
        self.nickNameTF.text = userId;
    }
}

#pragma mark - Action

- (IBAction)loginAction:(id)sender {
    NSString *userId = self.nickNameTF.text;
    if (userId.isEmpty) {
        [self.view show:@"UserId cannot be empty!"];
        return;
    }
    [self.view showHUD];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SendBirdToken];
    void(^completion)(SBDUser * _Nullable user, SBDError * _Nullable error) = ^(SBDUser * _Nullable user, SBDError * _Nullable error) {
        if (error != nil) {
            [self.view show:error.localizedDescription];
            return;
        }
        // 推送权限
        [SBDMain registerDevicePushToken:[SBDMain getPendingPushToken] unique:YES completionHandler:^(SBDPushTokenRegistrationStatus status, SBDError * _Nullable error) {
            if (error != nil) {
                NSLog(@"APNS registration failed.");
                return;
            }
            if (status == SBDPushTokenRegistrationStatusPending) {
                NSLog(@"Push registration is pending.");
            }
            else {
                NSLog(@"APNS Token is registered.");
            }
        }];
        NSLog(@"%@", user);
        [self.view hideHUD];
        [[NSUserDefaults standardUserDefaults] setObject:user.userId forKey:SendBirdUserId];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ChannelController * channelVC = [[ChannelController alloc] init];
        [self.navigationController pushViewController:channelVC animated:YES];
    };
    if (token.isEmpty) {
        // 登录（首次自动注册）
        [SBDMain connectWithUserId:userId completionHandler:^(SBDUser * _Nullable user, SBDError * _Nullable error) {
            completion(user, error);
        }];
    }
    else {
        [SBDMain connectWithUserId:userId accessToken:token completionHandler:^(SBDUser * _Nullable user, SBDError * _Nullable error) {
            completion(user, error);
        }];
    }

}
@end
