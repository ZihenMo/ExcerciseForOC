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

- (void)addTapAction: (TapAction)actionHandle;

@end

NS_ASSUME_NONNULL_END
