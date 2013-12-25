//
//  NSArray+RubySugar.h
//  RubySugar
//
//  Created by Michal Konturek on 24/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (RubySugar)

/**
 Drops first n elements from ary and returns the rest of the elements in an array.
 If a negative number is given, raises an ArgumentError.
 */
- (instancetype)rs_drop:(NSInteger)count;

/**
 Drops elements up to, but not including, the first element for which the block 
 returns nil or false and returns an array containing the remaining elements.
 
 If no block is given, an Enumerator is returned instead.
 */
- (id)rs_dropWhile:(BOOL(^)(id item))block;

- (instancetype)rs_take;
- (id)rs_takeWhile:(BOOL(^)(id item))block;


@end
