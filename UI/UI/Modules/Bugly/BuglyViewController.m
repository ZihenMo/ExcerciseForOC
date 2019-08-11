//
//  BuglyViewController.m
//  UI
//
//  Created by gshopper on 2019/7/30.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "BuglyViewController.h"

@interface BuglyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *errorDescriptionTextField;

@end

@implementation BuglyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark - Action
- (IBAction)debugAction:(id)sender {
}
- (IBAction)errorAction:(id)sender {
    NSArray *array = [NSArray array];
    id obj = array[1];
}
- (IBAction)otherAction:(id)sender {
}

@end
