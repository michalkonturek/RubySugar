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
 Returns new array by concatenating array with input object.
 
 Every object that responds to description selector is appended.
 */
- (instancetype):(id)object;

/**
 Returns self[@"<from>..<to>"]
 */
- (instancetype):(NSInteger)from :(NSInteger)to;

/**
 Returns self[@"<from>..<to>"] or self[@"<from>...<to>"] if exclusive.
 */
- (instancetype):(NSInteger)from :(NSInteger)to exclusive:(BOOL)exclusive;

/**
 Returns an empty array.
 */
- (instancetype)rs_clear;

/**
 Returns a copy of self with all nil elements removed.
 */
- (instancetype)rs_compact;

/***/
- (instancetype)rs_flatten;

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

/**
 Shorthand ([self count] == 0)
 */
- (BOOL)rs_isEmpty;

/**
 Shorthand [rs_join:nil]
 */
- (NSString *)rs_join;

/**
 Returns a string created by converting each element of the array to a string, 
 separated by the given separator. If the separator is nil, it uses empty string.
 */
- (NSString *)rs_join:(NSString *)separator;

/**
 Returns a new array containing self‘s elements in reverse order.
 */
- (instancetype)rs_reverse;

/**
 Returns first n elements from the array.
 If a negative number is given, raises an ArgumentError.
 */
- (instancetype)rs_take:(NSInteger)count;

/**
 Passes elements to the block until the block returns nil or false, 
 then stops iterating and returns an array of all prior elements.
 
 If no block is given, an Enumerator is returned instead.
 */
- (id)rs_takeWhile:(BOOL(^)(id item))block;


- (id)objectForKeyedSubscript:(id<NSCopying>)key;

@end
