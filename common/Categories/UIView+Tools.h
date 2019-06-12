//
//  UIView+Tools.h
//  UI
//
//  Created by gshopper on 2019/5/22.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TapAction)(UIView *sender);
@interface UIView (Tools)
@property (nonatomic, copy) TapAction actionHandle;

/**
 * 点击事件

 @param actionHandle 点击回调
 */
- (void)addTapAction: (TapAction)actionHandle;

/**
 *  @brief 在 delay秒之后，执行action操作
 *
 *  @param action    执行的操作
 *  @param newObject 参数
 *  @param delay     延时时间
 */
- (void)debounceAction:(SEL)action object:(id)newObject delay:(NSTimeInterval)delay;

@end

@interface UIView (HUD)

/**
 * 显示提示信息

 @param message 信息内容
 */
- (void)show: (NSString *)message;
- (void)showHUD;
- (void)hideHUD;
@end

NS_ASSUME_NONNULL_END
