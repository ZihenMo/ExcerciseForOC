//
//  CustomizedKeyBoardController.m
//  UI
//
//  Created by gshopper on 2019/6/19.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "CustomizedKeyBoardController.h"
#import "KeyBoardView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface CustomizedKeyBoardController ()

@property (nonatomic, weak) IBOutlet UITextField *tf;

@end

@implementation CustomizedKeyBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    KeyBoardView *keyBoard = [[KeyBoardView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    self.tf.inputView = keyBoard;
    self.tf.inputAccessoryView = nil;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAssessoryView:) name:UIKeyboardDidShowNotification object:nil];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;   // 去掉inputAssessoryView
}

@end
