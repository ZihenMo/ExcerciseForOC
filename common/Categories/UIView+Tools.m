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

+(void)debounceForTarget:(id)target action:(SEL)action object:(id)newObject delay:(NSTimeInterval)delay{
    
    if(target == nil || action == nil){ return;}
    
    // NSString *selectorString = NSStringFromSelector(action);
    // id oldObj = objc_getAssociatedObject(target,[selectorString UTF8String]); // WRONG
    id oldObj = objc_getAssociatedObject(target,action);
    //NSLog(@"oldObj:%@",oldObj);
    [NSObject cancelPreviousPerformRequestsWithTarget:target selector:action object:oldObj];
    
    // Why do we need to retain this object???
    objc_setAssociatedObject(target, action, newObject, OBJC_ASSOCIATION_RETAIN);
    [target performSelector:action withObject:newObject afterDelay:delay];
    
}

-(void)debounceAction:(SEL)action object:(id)newObject delay:(NSTimeInterval)delay{
    [[self class] debounceForTarget:self action:action object:newObject delay:delay];
}


+(void)debounceForTarget:(id)target action:(SEL)action objectToBeCancelled:(id)oldObject objectToBePerform:(id)newObject delay:(NSTimeInterval)delay{
    
    NSAssert(target != nil, @"target 不能为nil", nil);
    
    // !!! call this method may cancel other actions ,
    //[NSObject cancelPreviousPerformRequestsWithTarget:target];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:target selector:action object:oldObject];
    
    //    [NSObject cancelPreviousPerformRequestsWithTarget:target selector:action object:object];
    //  the Argument [object] may be different with last performrequest,if so,the last perform will not be cancelled.
    [target performSelector:action withObject:newObject afterDelay:delay];
    
}

#pragma mark - Getter & Setter
- (void)setActionHandle:(TapAction)actionHandle {
    objc_setAssociatedObject(self, @selector(actionHandle), actionHandle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (TapAction)actionHandle {
    return objc_getAssociatedObject(self, @selector(actionHandle));
}
@end

#pragma mark - HUD
@implementation UIView (HUD)
- (void)show:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.graceTime = 2.0;
}

- (void)showHUD {
    [MBProgressHUD showHUDAddedTo:self animated:YES];
}

- (void)hideHUD {
    [MBProgressHUD hideHUDForView:self animated:YES];
}

@end
