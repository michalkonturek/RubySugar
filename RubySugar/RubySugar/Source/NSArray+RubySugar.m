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
    NSRange range = NSMakeRange(count, [self count] - count);
    return [self subarrayWithRange:range];
}

- (id)rs_dropWhile:(BOOL(^)(id item))block {

    NSInteger count = 0;
    for (id item in self) {
        if (block(item)) count++;
        else break;
    }
    
    return [self rs_drop:count];
}

- (instancetype)rs_take {
    return nil;
}

- (id)rs_takeWhile:(BOOL(^)(id item))block {
    return nil;
}

@end
