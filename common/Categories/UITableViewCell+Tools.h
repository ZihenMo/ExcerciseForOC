//
//  UITableViewCell+Tools.h
//  SendbirdChat
//
//  Created by mozihen on 2019/6/23.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CellBindDataDelegate <NSObject>

/**
 定义统一的数据绑定方法。
 数据模型的类型可以是自定义类或字典。若是字典请注释好字典的键名。
 @param data 数据模型
 */
- (void)bindData: (id)data;

@end

@interface UITableViewCell (Tools)<CellBindDataDelegate>

@end

NS_ASSUME_NONNULL_END
