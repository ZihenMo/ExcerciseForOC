//
//  Person.h
//  UI
//
//  Created by mozihen on 2019/5/4.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface GRPerson : NSObject

@property (nonatomic, copy) NSString *nickName;
// 避免与description重名
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *sectionIndex;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) NSInteger uid;



@end

NS_ASSUME_NONNULL_END
