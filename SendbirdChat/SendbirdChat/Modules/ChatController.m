//
//  ChatController.m
//  SendbirdChat
//
//  Created by gshopper on 2019/6/10.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "ChatController.h"
#import <SendBirdSDK/SendBirdSDK.h>
#import "MessageCell.h"
#import "PicTextButton.h"

@interface ChatController ()<UITableViewDelegate, UITableViewDataSource, SBDChannelDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIView *toolsView;
@property (weak, nonatomic) IBOutlet PicTextButton *pictureButton;
@property (weak, nonatomic) IBOutlet PicTextButton *cameraButton;
@property (weak, nonatomic) IBOutlet PicTextButton *fileButton;
@property (weak, nonatomic) IBOutlet PicTextButton *videoButton;

@property (nonatomic, strong) NSMutableArray *messageList;
@end

@implementation ChatController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [SBDMain addChannelDelegate:self identifier:[[NSUserDefaults standardUserDefaults] objectForKey:SendBirdUserId]];
    [self loadPreviousMessage];
}

- (void)setupUI {
    self.pictureButton.type = PicTextTypePicRight;
    self.cameraButton.type = PicTextTypePicTop;
    self.fileButton.type = PicTextButtonPicLeft;
    self.videoButton.type = PicTextTypePicBottom;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
- (IBAction)sendAction:(id)sender {
    NSString *message = self.textField.text;
    if (message.isEmpty || self.channel == nil) {
        return;
    }
    SBDUserMessageParams *params = [[SBDUserMessageParams alloc] initWithMessage:message];
//    [params setCustomType:@""]; // 用来筛选
    [params setData:message];
//    [params setMentionType:SBDMentionTypeUsers];        // Either SBDMentionTypeUsers or SBDMentionTypeChannel
//    [params setMentionedUserIds:@[userId, serviceId]];  // or setMentionedUsers:
//    [params setMetaArrayKeys:@[@"key1", @"key2"]];
//    [params setTargetLanguages:@[@"fr", @"de"]];        // French and German
    
    [params setPushNotificationDeliveryOption:SBDPushNotificationDeliveryOptionDefault];
    
    [self.channel sendUserMessageWithParams:params completionHandler:^(SBDUserMessage * _Nullable userMessage, SBDError * _Nullable error) {
        if (error != nil) { // Error.
            [self.view show:error.localizedDescription];
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.messageList addObject:userMessage];
            [self.tableView reloadData];
        });
    }];
}
#pragma mark - UITableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    SBDUserMessage *message = self.messageList[indexPath.row];
//    [cell setMessage:message.message];
    cell.textLabel.text = message.message;
    cell.textLabel.layer.cornerRadius = 4.0;
    cell.textLabel.layer.masksToBounds = YES;
//    cell.textLabel.textColor = UIColor.whiteColor;
    [cell.textLabel sizeToFit];
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:SendBirdUserId];
    if ([message.sender.userId isEqualToString:userId]) {
        cell.textLabel.textAlignment = NSTextAlignmentRight;
//        cell.textLabel.backgroundColor = UIColor.purpleColor;
    }
    else {
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}
#pragma mark - Message

/**
 加载历史消息
 */
- (void)loadPreviousMessage {
    if (self.channel == nil) { return; }
    SBDPreviousMessageListQuery *previousMessageQuery = [self.channel createPreviousMessageListQuery];
    [previousMessageQuery loadPreviousMessagesWithLimit:30 reverse:YES completionHandler:^(NSArray<SBDBaseMessage *> * _Nullable messages, SBDError * _Nullable error) {
        if (error != nil) { // Error.
            return;
        }
        if (messages.count > 0) {
            NSLog(@"有历史消息");
        }
        self.messageList = [messages arrayByAddingObjectsFromArray:self.messageList].mutableCopy;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}
#pragma mark - Channel Delegate
// 接收消息
- (void)channel:(SBDBaseChannel *)sender didReceiveMessage:(SBDBaseMessage *)message {
    if ([message isKindOfClass:SBDUserMessage.class]) {
        SBDUserMessage *userMessage = (SBDUserMessage *)message;
        [self.messageList addObject:userMessage];
        [self.tableView reloadData];
    }
    if ([message isKindOfClass:SBDFileMessage.class]) {
        // 处理文件消息
    }
}

- (void)dealloc
{
    [SBDMain removeChannelDelegateForIdentifier:[[NSUserDefaults standardUserDefaults] objectForKey:SendBirdUserId]];
}

#pragma mark - Getter
- (NSMutableArray *)messageList {
    if (_messageList == nil) {
        _messageList = [NSMutableArray array];
    }
    return _messageList;
}
@end
