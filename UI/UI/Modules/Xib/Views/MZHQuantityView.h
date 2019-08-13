//
//  MZHQuantityView.h
//  UI
//
//  Created by gshopper on 2019/8/7.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MZHQuantityView : UIView

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, assign) NSInteger min;
@property (nonatomic, assign) NSInteger max;
@property (nonatomic, assign) NSInteger step;

@end

NS_ASSUME_NONNULL_END
