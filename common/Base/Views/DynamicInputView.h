//
//  DynamicInputView.h
//  UI
//
//  Created by gshopper on 2019/6/27.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DynamicInputView;
@protocol DynamicInputViewDelegate <NSObject>
@optional
- (BOOL)dynamicInputViewShouldBeginEditing:(DynamicInputView *_Nonnull)dynamicInputView;
- (void)dynamicInputViewDidBeginEditing:(DynamicInputView *_Nonnull)dynamicInputView;
- (BOOL)dynamicInputViewShouldEndEditing:(DynamicInputView *_Nonnull)dynamicInputView;
- (void)dynamicInputViewDidEndEditing:(DynamicInputView *_Nonnull)dynamicInputView;
- (BOOL)dynamicInputView:(DynamicInputView *_Nonnull)dynamicInputView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *_Nullable)string;
- (BOOL)dynamicInputViewShouldClear:(DynamicInputView *_Nonnull)dynamicInputView;
- (BOOL)dynamicInputViewShouldReturn:(DynamicInputView *_Nonnull)dynamicInputView;
@end

typedef enum : NSUInteger {
    DynamicInputTypeDefault,
    DynamicInputTypeSecurity
} DynamicInputType;

NS_ASSUME_NONNULL_BEGIN

@interface DynamicInputView : UIView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, assign) DynamicInputType type;

/**
 底线颜色, 默认浅灰色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 底线激活/提示颜色,默认红色
 */
@property (nonatomic, strong) UIColor *lineFocusColor;
@property (nonatomic, weak) id<DynamicInputViewDelegate> delegate;
- (void)showWarning;
- (void)hideWarning;

@end

NS_ASSUME_NONNULL_END
