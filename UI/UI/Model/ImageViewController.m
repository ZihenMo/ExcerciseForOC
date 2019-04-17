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
    /* 默认以图片初始化时，大小等同图片，
     * 即所谓的内在内容尺寸，label也是如此。
     */
    UIImage *image = [UIImage imageWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"stand_1" ofType:@"png"]];
    UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:image];
    tmpImageView.center = CGPointMake(self.view.center.x, self.view.center.y + 100.f);
    NSLog(@"image.size: %@", NSStringFromCGSize(image.size));
    NSLog(@"tmpImageView: %@", NSStringFromCGSize( tmpImageView.intrinsicContentSize));
    NSLog(@"tmpImageView.frame: %@", NSStringFromCGRect(tmpImageView.frame));
    [self.view addSubview:tmpImageView];
}
#pragma mark - Actions

- (IBAction)playSkillAction:(UIButton *)sender {

}
- (IBAction)shutdownAction:(UIButton *)sender {
}

- (void)play {
    
}

@end
