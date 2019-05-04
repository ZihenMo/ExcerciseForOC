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
/** 去空 */
- (id)processDictionaryIsNSNull;
@end
