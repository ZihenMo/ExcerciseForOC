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
    
}
#pragma mark - Actions

- (IBAction)playSkillAction:(UIButton *)sender {
    
}
- (IBAction)shutdownAction:(UIButton *)sender {
}

- (void)play {
    
}

@end
