//
//  MZHTreeNode.h
//  UI
//
//  Created by gshopper on 2019/10/28.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MZHTreeNode <NSObject>

@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) id <MZHTreeNode> parentNode;
@property (nonatomic, strong) NSArray *childNodeList;

@end

@interface MZHTreeNode : NSObject <MZHTreeNode>

@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
