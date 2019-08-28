//
//  PersonDetailController.h
//  UI
//
//  Created by gshopper on 2019/9/27.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PersonRefreshBlock)(void);
@class GRPerson;
@interface PersonDetailController : UIViewController

@property (nonatomic, strong) GRPerson *person;
@property (nonatomic, copy) PersonRefreshBlock refreshBlock;

@end

NS_ASSUME_NONNULL_END
