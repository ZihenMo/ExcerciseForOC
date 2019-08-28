//
//  UIDevice+Tools.h
//  UI
//
//  Created by gshopper on 2019/9/2.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Tools)


/**
 是否越狱

 @return 越狱为真
 */
+ (BOOL)isJailbreak;

@end

NS_ASSUME_NONNULL_END
