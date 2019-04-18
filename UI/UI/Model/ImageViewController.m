//
//  ImageViewController.m
//  UI
//
//  Created by mozihen on 2019/4/17.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "ImageViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) AVPlayer *player;


@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self standAction];
}
#pragma mark - Actions

- (IBAction)playSkillAction:(UIButton *)sender {
    switch (sender.tag) {
        case 101:   // small Skill
            [self playWithSkillName:@"xiaozhao1" andImageCount:10 isStanded:YES];
            break;
        case 102: // big Skill
            [self playWithSkillName:@"dazhao" andImageCount:10 isStanded:YES];

        default:
            break;
    }
}
- (IBAction)shutdownAction:(UIButton *)sender {
    self.imageView.animationImages = nil;
}

- (void)standAction {
    [self playWithSkillName:@"stand" andImageCount:10 isStanded:YES];
}

- (void)playWithSkillName: (NSString *)name andImageCount: (NSInteger)count isStanded: (BOOL)isStanded {
    NSMutableArray <UIImage *> *images = [NSMutableArray array];
    for (NSInteger i = 0; i < count; ++i) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%ld",name, (long)i] ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [images addObject:image];
    }
    self.imageView.animationImages = images;
    self.imageView.animationDuration = 30.f / count;    // 帧率30
    if (isStanded) {
        self.imageView.animationRepeatCount = 0;
    }
    else {
        self.imageView.animationRepeatCount = 1;    // 只播放一次
        [self performSelector:@selector(standAction) withObject:nil afterDelay:self.imageView.animationDuration];
    }
}

- (void)playSoundWithName:(NSString *)name {
    NSURL *itemUrl = [[NSBundle mainBundle] URLForResource:name withExtension:@"mp3"];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:itemUrl];
    [self.player replaceCurrentItemWithPlayerItem:item];
//    [self.player play];
}
#pragma mark - Getter
- (AVPlayer *)player {
    if (!_player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}



@end
