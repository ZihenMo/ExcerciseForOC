//
//  NSArray+Tool.m
//  gshopper
//
//  Created by jackcao on 2018/5/23.
//  Copyright © 2018年 gshopper. All rights reserved.
//

#import "NSArray+Tool.h"
#import <objc/runtime.h>

@implementation NSArray (Tool)

#pragma mark - 数组 转 json字符串
- (NSString *)toJsonString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        // 1.转化为 JSON 格式的 NSData
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            NSLog(@"数组转JSON字符串失败：%@", error.localizedDescription);
        }
        // 2.转化为 JSON 格式的 NSString
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

#pragma mark - 数组倒序
- (NSArray *)reverse {
    return [[self reverseObjectEnumerator] allObjects];
}

#pragma mark - Compare
- (BOOL)isEqualTo:(NSArray *)array{
    if (self.count != array.count) {
        return NO;
    }
    for (NSString *str in self) {
        if (![array containsObject:str]) {
            return NO;
        }
    }
    return YES;
}
@end

@implementation NSArray (Safe)
//
//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        @autoreleasepool {
//            [objc_getClass("__NSArray0") replaceMethodWithOriginSel:@selector(objectAtIndex:) aspectSel:@selector(emptyObjectIndex:)];
//            [objc_getClass("__NSArrayI") replaceMethodWithOriginSel:@selector(objectAtIndex:) aspectSel:@selector(arrObjectIndex:)];
//            [objc_getClass("__NSArrayM") replaceMethodWithOriginSel:@selector(objectAtIndex:) aspectSel:@selector(mutableObjectIndex:)];
//            [objc_getClass("__NSArrayM") replaceMethodWithOriginSel:@selector(insertObject:atIndex:) aspectSel:@selector(mutableInsertObject:atIndex:)];
//        }
//    });
//}

- (id)emptyObjectIndex:(NSInteger)index{
    return nil;
}

- (id)arrObjectIndex:(NSInteger)index{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self arrObjectIndex:index];
}

- (id)mutableObjectIndex:(NSInteger)index{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self mutableObjectIndex:index];
}

- (void)mutableInsertObject:(id)object atIndex:(NSUInteger)index{
    if (object) {
        [self mutableInsertObject:object atIndex:index];
    }
}

#if DEBUG
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *desc = [NSMutableString string];
    
    NSMutableString *tabString = [[NSMutableString alloc] initWithCapacity:level];
    for (NSUInteger i = 0; i < level; ++i) {
        [tabString appendString:@"\t"];
    }
    
    NSString *tab = @"";
    if (level > 0) {
        tab = tabString;
    }
    [desc appendString:@"\t[\n"];
    
    for (id obj in self) {
        if ([obj isKindOfClass:[NSDictionary class]]
            || [obj isKindOfClass:[NSArray class]]
            || [obj isKindOfClass:[NSSet class]]) {
            NSString *str = [((NSDictionary *)obj) descriptionWithLocale:locale indent:level + 1];
            [desc appendFormat:@"%@\t%@,\n", tab, str];
        } else if ([obj isKindOfClass:[NSString class]]) {
            [desc appendFormat:@"%@\t\"%@\",\n", tab, obj];
        } else if ([obj isKindOfClass:[NSData class]]) {
            // 如果是NSData类型，尝试去解析结果，以打印出可阅读的数据
            NSError *error = nil;
            NSObject *result =  [NSJSONSerialization JSONObjectWithData:obj
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&error];
            // 解析成功
            if (error == nil && result != nil) {
                if ([result isKindOfClass:[NSDictionary class]]
                    || [result isKindOfClass:[NSArray class]]
                    || [result isKindOfClass:[NSSet class]]) {
                    NSString *str = [((NSDictionary *)result) descriptionWithLocale:locale indent:level + 1];
                    [desc appendFormat:@"%@\t%@,\n", tab, str];
                } else if ([obj isKindOfClass:[NSString class]]) {
                    [desc appendFormat:@"%@\t\"%@\",\n", tab, result];
                }
            } else {
                @try {
                    NSString *str = [[NSString alloc] initWithData:obj encoding:NSUTF8StringEncoding];
                    if (str != nil) {
                        [desc appendFormat:@"%@\t\"%@\",\n", tab, str];
                    } else {
                        [desc appendFormat:@"%@\t%@,\n", tab, obj];
                    }
                }
                @catch (NSException *exception) {
                    [desc appendFormat:@"%@\t%@,\n", tab, obj];
                }
            }
        } else {
            [desc appendFormat:@"%@\t%@,\n", tab, obj];
        }
    }
    
    [desc appendFormat:@"%@]", tab];
    
    return desc;
}
#endif

@end



