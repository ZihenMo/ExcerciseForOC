//
//  ALButton.h
//  AutoLayout
//
//  Created by mozihen on 2019/4/1.
//  Copyright © 2019 mzh. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 混排样式
 图与标题的位置
 */
typedef enum : NSUInteger {
    PicTextTypePicTop,
    PicTextTypePicBottom,
    PicTextButtonPicLeft,
    PicTextTypePicRight
} PicTextType;
NS_ASSUME_NONNULL_BEGIN

@interface BaseButton : UIButton
@property (nonatomic, assign) PicTextType type;

@end

NS_ASSUME_NONNULL_END
