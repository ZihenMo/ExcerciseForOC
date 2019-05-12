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
@property (nonatomic, strong) NSArray *standImages;
@property (nonatomic, strong) NSArray *smallSkillImages;
@property (nonatomic, strong) NSArray *bigSkillImages;


@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /* 默认以图片初始化时，大小等同图片，
     * 即所谓的内在内容尺寸，label也是如此。
     */
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self standAction];
    [self test];
}
#pragma mark - Actions
/**
 测试内在内容与frame关系
 */
- (void)test {
// 图片的两种加载方式
    UIImage *image = [UIImage imageNamed:@"stand"];
//    UIImage *image = [UIImage imageWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"stand" ofType:@"png"]];
    UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:image];
    tmpImageView.center = CGPointMake(self.view.center.x, self.view.center.y + 100.f);
    NSLog(@"image.size: %@", NSStringFromCGSize(image.size));
    NSLog(@"tmpImageView: %@", NSStringFromCGSize( tmpImageView.intrinsicContentSize));
    NSLog(@"tmpImageView.frame: %@", NSStringFromCGRect(tmpImageView.frame));
    [self.view addSubview:tmpImageView];
}
 #pragma mark - 图片拉伸与修复
- (IBAction)strechImageAction:(UIButton *)sender {
    [self.imageView stopAnimating];
    // 默认拉伸变模糊
    UIImage *image = [UIImage imageNamed:@"chat"];
    // 1. 拉伸
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.height * 0.5, image.size.width * 0.5) resizingMode:UIImageResizingModeStretch];
    // 另一种
//    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5 ];
    self.imageView.image = image;
    
}
 #pragma mark - 播放动画
- (IBAction)playSkillAction:(UIButton *)sender {
    switch (sender.tag) {
        case 101:   // small Skill
            [self playSkillWithImages:self.smallSkillImages isStanded:NO];
            break;
        case 102: // big Skill
            [self playSkillWithImages:self.bigSkillImages isStanded:NO];
            break;
        default:
            break;
    }
}
- (IBAction)shutdownAction:(UIButton *)sender {
    self.imageView.animationImages = nil;
}

- (void)standAction {
    [self playSkillWithImages:self.standImages isStanded:YES];
}

- (NSArray <UIImage *> *)loadImages: (NSString *)name andImageCount: (NSInteger)count {
    NSMutableArray <UIImage *> *images = [NSMutableArray array];
    for (NSInteger i = 0; i < count; ++i) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%ld",name, (long)i+1] ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [images addObject:image];
    }
    return images;
}

- (void)playSkillWithImages: (NSArray <UIImage*> *)images isStanded: (BOOL)isStanded {
    self.imageView.animationImages = images;
    self.imageView.animationDuration = images.count / 25.f;    // 帧率30
    self.imageView.animationRepeatCount = isStanded ? 0 : 1;
    [self.imageView startAnimating]; // 开始播放动画
    if (!isStanded) {
        NSInteger duration = self.imageView.animationDuration + 0.5;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.imageView stopAnimating];
            [self standAction];
        });
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
- (NSArray *)smallSkillImages {
    if (_smallSkillImages == nil) {
        _smallSkillImages = [self loadImages:@"xiaozhao1" andImageCount:21];
    }
    return _smallSkillImages;
}
- (NSArray *)bigSkillImages {
    if (_bigSkillImages == nil) {
        _bigSkillImages = [self loadImages:@"dazhao" andImageCount:87];
    }
    return _bigSkillImages;
}
- (NSArray *)standImages {
    if (_standImages == nil) {
        _standImages = [self loadImages:@"stand" andImageCount:10];
    }
    return _standImages;
}


@end
