//
//  AppDelegate.m
//  SendbirdChat
//
//  Created by gshopper on 2019/5/23.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "AppDelegate.h"
#import <SendBirdSDK/SendBirdSDK.h>

NSString *APP_ID = @"429CACE9-6D11-4072-9047-001135BD005D";


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    UIViewController *rootVC = [[UIViewController alloc] init];
//
//    rootVC.view.backgroundColor = UIColor.redColor;
//    self.window.rootViewController = rootVC;
//    [self.window makeKeyAndVisible];
    
    [SBDMain initWithApplicationId:APP_ID];
    [self apperance];

    return YES;
}

- (void)apperance {
    UITableViewCell.appearance.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [[GIDSignIn sharedInstance] handleURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[GIDSignIn sharedInstance] handleURL:url];
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
