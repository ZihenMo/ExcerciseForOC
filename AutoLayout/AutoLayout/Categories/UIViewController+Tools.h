//
//  UIViewController+Tools.h
//  Infrastructure
//
//  Created by gshopper on 2019/3/21.
//  Copyright © 2019 mzh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Tools)

+ (UIViewController *) getCurrentViewController;

- (void)showAlertWith:(NSString *) message;


@end

NS_ASSUME_NONNULL_END
