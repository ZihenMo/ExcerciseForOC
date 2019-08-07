//
//  NSDictionary+Tool.h
//  gshopper
//
//  Created by jackcao on 2018/5/23.
//  Copyright © 2018年 gshopper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Tool)
/** 字典 转 json字符串 */
- (nullable NSString *)toJsonString;
/** 把字典拼成url字符串 */
- (nullable NSString *)toURLString;
/** 空值替换为空字符串 */
/**
 替换空值为指定对象，若不指定Object，则替换成空字符串。

 @param obj 指定对象
 @return  过滤后的字典
 */
- (instancetype)replaceNullValueWithObject: (id _Nullable) obj;
@end
