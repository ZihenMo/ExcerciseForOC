//
//  CaculatorController.m
//  RAC
//
//  Created by gshopper on 2019/4/2.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "CaculatorController.h"

@interface CaculatorController ()
@property (weak, nonatomic) IBOutlet UITextField *numTF1;
@property (weak, nonatomic) IBOutlet UITextField *operatioinTF;
@property (weak, nonatomic) IBOutlet UITextField *numTF2;
@property (weak, nonatomic) IBOutlet UILabel *resultLbl;

@end

@implementation CaculatorController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)caculateAction:(UIButton *)sender {
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
