//
//  NSArray+RubySugar.m
//  RubySugar
//
//  Created by Michal Konturek on 24/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import "NSArray+RubySugar.h"

#import "NSNumber+RubySugar.h"

@implementation NSArray (RubySugar)

- (instancetype)rs_drop:(NSInteger)count {
    if (count < 0) @throw [NSException exceptionWithName:NSInvalidArgumentException
                                                  reason:NSInvalidArgumentException
                                                userInfo:nil];
    
    if (count > (NSInteger)self.count) return [NSArray array];
    
    NSRange range = NSMakeRange(count, [self count] - count);
    return [self subarrayWithRange:range];
}

- (id)rs_dropWhile:(BOOL(^)(id item))block {
    if (!block) return [self objectEnumerator];
    
    NSInteger count = 0;
    for (id item in self) {
        if (block(item)) count++;
        else break;
    }
    
    return [self rs_drop:count];
}

- (instancetype)rs_take:(NSInteger)count {
    if (count < 0) @throw [NSException exceptionWithName:NSInvalidArgumentException
                                                  reason:NSInvalidArgumentException
                                                userInfo:nil];
    
    if (count > (NSInteger)self.count) return self;
    
    NSInteger length = (count > self.count) ? self.count : count;
    return [self subarrayWithRange:NSMakeRange(0, length)];
}

- (id)rs_takeWhile:(BOOL(^)(id item))block {
    if (!block) return [self objectEnumerator];
    
    NSInteger count = 0;
    for (id item in self) {
        if (block(item)) count++;
        else break;
    }
    
    return [self rs_take:count];
}

- (BOOL)rs_isEmpty {
    return ([self count] == 0);
}

@end
