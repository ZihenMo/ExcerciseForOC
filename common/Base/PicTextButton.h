//
//  PicTextButton.h
//  SendbirdChat
//
//  Created by mozihen on 2019/6/24.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "BaseButton.h"

NS_ASSUME_NONNULL_BEGIN

/** 混排样式
 图与标题的位置
 */
typedef enum : NSUInteger {
    PicTextTypePicTop,
    PicTextTypePicBottom,
    PicTextButtonPicLeft,
    PicTextTypePicRight
} PicTextType;
/**
 图文混排按钮
 */
@interface PicTextButton : BaseButton
@property (nonatomic, assign) PicTextType type;

- (instancetype)initWithPicTextType: (PicTextType)type;

@end

NS_ASSUME_NONNULL_END
