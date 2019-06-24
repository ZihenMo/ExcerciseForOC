//
//  ChannelController.m
//  SendbirdChat
//
//  Created by gshopper on 2019/6/10.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <SendBirdSDK/SendBirdSDK.h>
#import "ChannelController.h"
#import "ChatController.h"
#import "ChannelCell.h"

@interface ChannelController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *channels;

@end

@implementation ChannelController
#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self showList];
}

- (void)setupUI {
    self.title = @"频道列表";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(ChannelCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(ChannelCell.class)];
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

#pragma mark - LoadList
- (void)showList {
//    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:SendBirdUserId];
    if ([SBDMain getConnectState] == SBDWebSocketClosed) {
        // 重新登录
        NSLog(@"-- 需要重新登录 -- ");
        return;
    }
    // 检索已有频道
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        SBDGroupChannelListQuery *groupChannel = [SBDGroupChannel createMyGroupChannelListQuery];
        groupChannel.limit = 20;
        groupChannel.order = SBDGroupChannelListOrderLatestLastMessage;
        [groupChannel loadNextPageWithCompletionHandler:^(NSArray<SBDGroupChannel *> * _Nullable channels, SBDError * _Nullable error) {
            if (error) {
                [self.view show:error.localizedDescription];
                return;
            }
            if (channels.count > 0) {
                [self.channels addObjectsFromArray:channels];
                [self.tableView reloadData];
            }
        }];
    });
    
    UIBarButtonItem *crateBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"创建聊天" style:UIBarButtonItemStylePlain target:self action:@selector(createGroupChannel)];
    self.navigationItem.rightBarButtonItem = crateBtnItem;
}


/**
 创建聊天频道
 */
- (void)createGroupChannel {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入客服ID" message:nil preferredStyle:UIAlertControllerStyleAlert];
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:SendBirdUserId];
    __block NSString *serviceId;
    UIAlertAction *okAciton = [UIAlertAction actionWithTitle:@"连接" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.view endEditing:YES];
        // isDistinct 创建相同成员的频道会合并消息
        [SBDGroupChannel createChannelWithUserIds:@[userId, serviceId]isDistinct:YES completionHandler:^(SBDGroupChannel * _Nullable channel, SBDError * _Nullable error) {
            if (error != nil) {
                [self.view show:error.localizedDescription];
                return;
            }
            NSLog(@"channelID: %@\n name: %@", channel.channelUrl, channel.name);
            [self.channels addObject:channel];
            [self.tableView reloadData];
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            if (x.isEmpty) {
                return;
            }
            serviceId = x;
        }];
    }];
    [alert addAction:okAciton];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - TableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.channels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ChannelCell.class) forIndexPath:indexPath];
    SBDGroupChannel * groupChannel = self.channels[indexPath.row];
//    cell.textLabel.text = groupChannel.name;
    NSString *membersName = @"";
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:SendBirdUserId];
    // 显示已经接的ID
    for (SBDMember *member in groupChannel.members) {
        if (![member.userId isEqualToString:userId]) {
            membersName = [membersName stringByAppendingFormat:@"%@\t", member.userId];
        }
    }
    [cell bindData:@{@"coverUrl": groupChannel.coverUrl,
                     @"title": membersName}];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatController *chatVC = [[ChatController alloc] init];
    chatVC.channel = self.channels[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
}

#pragma mark - Getter
- (NSMutableArray *)channels {
    if (_channels == nil) {
        _channels = [NSMutableArray array];
    }
    return _channels;
}
@end
