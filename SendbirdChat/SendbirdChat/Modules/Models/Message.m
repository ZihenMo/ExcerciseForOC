//
//  Message.m
//  SendbirdChat
//
//  Created by mozihen on 2019/6/23.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "Message.h"
@interface Message()
@property (nonatomic, strong) SBDBaseMessage *sourceMessage;

@end

@implementation Message

- (instancetype)initWithMessage:(SBDBaseMessage *)message {
    if (self = [super init]) {
        _sourceMessage = message;
    }
    return self;
}

- (MessageType)type {
    if ([_sourceMessage isKindOfClass:SBDUserMessage.class]) {
        return MessageTypeText;
    }
    if ([_sourceMessage isKindOfClass:SBDAdminMessage.class]) {
        return MessageTypeAdmin;
    }
    if ([_sourceMessage isKindOfClass:SBDFileMessage.class] ) {
        if ([((SBDFileMessage *)_sourceMessage).type hasPrefix:@"image"]) {
            return MessageTypeFile;
        }
        return MessageTypeFile;
    }
    return MessageTypeOther;
}

@end
