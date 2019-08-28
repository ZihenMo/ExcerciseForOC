//
//  Person.h
//  Grammer
//
//  Created by gshopper on 2019/7/2.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GRPerson : NSObject

@property (nonatomic, copy) NSString  *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) id observer;

- (void)doSomething;
- (void)doB;
@end

@interface GRPerson ()

- (void)doExtensionMethod;
@end


NS_ASSUME_NONNULL_END
