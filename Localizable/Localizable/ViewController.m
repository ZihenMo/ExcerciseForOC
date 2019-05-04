//
//  ViewController.m
//  Localizable
//
//  Created by gshopper on 2019/4/22.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label.text = Localized(@"paragraph");
}

#pragma mark - Actions
- (IBAction)switchLanguageAction:(UIButton*)sender {
    switch (sender.tag) {
        case 0:
            // 英
            break;

        case 1:
            // 中
            break;
        case 2:
            // 日
            break;
        case 3:
            // 韩
            break;
            
        default:
            break;
    }
}


@end
