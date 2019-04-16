//
//  DataUpdateOperation.h
//  RecycleReference
//
//  Created by mozihen on 2019/4/15.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataUpdateOperation : NSObject

- (void)startWithDelegate: (id) delegate withSelector: (SEL) selector;

@end

NS_ASSUME_NONNULL_END
