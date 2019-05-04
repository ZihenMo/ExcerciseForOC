//
//  NSArray+Tool.h
//  gshopper
//
//  Created by jackcao on 2018/5/23.
//  Copyright © 2018年 gshopper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Tool)
/** 数组/字典 转 json字符串 */
- (nullable NSString *)toJsonString;
/** 数组倒序 */
- (NSArray *)reverse;
/** 数组比较 */
- (BOOL)isEqualTo:(NSArray *)array;
@end


@interface NSArray (Safe)

@end
