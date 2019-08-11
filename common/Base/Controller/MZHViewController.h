//
//  BaseViewController.h
//  AutoLayout
//
//  Created by mozihen on 2019/4/8.
//  Copyright © 2019 mzh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MZHNavigationBar;
@interface MZHViewController : UIViewController

/**
 自定义导航栏
 */
@property (nonatomic, strong) MZHNavigationBar *navigationBar;

@end

NS_ASSUME_NONNULL_END
