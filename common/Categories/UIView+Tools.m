//
//  UIView+Tools.m
//  UI
//
//  Created by gshopper on 2019/5/22.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "UIView+Tools.h"
#import <objc/runtime.h>


@implementation UIView (Tools)

- (void)addTapAction:(TapAction)actionHandle {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    self.actionHandle = actionHandle;
    [self addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (self.actionHandle) {
        self.actionHandle(self);
    }
}

#pragma mark - Getter & Setter
- (void)setActionHandle:(TapAction)actionHandle {
    objc_setAssociatedObject(self, @selector(actionHandle), actionHandle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (TapAction)actionHandle {
    return objc_getAssociatedObject(self, @selector(actionHandle));
}
@end
