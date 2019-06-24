//
//  Message.h
//  SendbirdChat
//
//  Created by mozihen on 2019/6/23.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <SendBirdSDK/SendBirdSDK.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    MessageTypeText,
    MessageTypeAdmin,
    MessageTypeImage,
    MessageTypeFile,
    MessageTypeOther
} MessageType;
@interface Message : SBDBaseMessage

@property (nonatomic, assign) MessageType type;

- (instancetype)initWithMessage: (SBDBaseMessage *)message;

@end

NS_ASSUME_NONNULL_END
