//
//  ChatController.h
//  SendbirdChat
//
//  Created by gshopper on 2019/6/10.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class  SBDGroupChannel;
@interface ChatController : UIViewController
@property (nonatomic, strong) SBDGroupChannel *channel;
@end

NS_ASSUME_NONNULL_END
