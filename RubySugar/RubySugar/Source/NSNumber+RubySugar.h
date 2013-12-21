//
//  NSNumber+RubySugar.h
//  RubySugar
//
//  Created by Michal Konturek on 18/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (RubySugar)

/**
 Returns the greatest common divisor (always positive).
 */
- (instancetype)rs_gcd:(NSInteger)other;

/**
 Returns the least common multiple (always positive).
 */
- (instancetype)rs_lcm:(NSInteger)other;

/**
 Returns successor integer, i.e. i + 1.
 */
- (instancetype)rs_next;

/**
 Returns predecessor integer, i.e. i - 1.
 */
- (instancetype)rs_pred;

- (void)rs_times:(void(^)(void))block;
- (void)rs_timesWithIndex:(void(^)(NSInteger index))block;


/**
 Iterates block, passing decreasing values from integer down to and including limit.
 Returns self. If no block is given, an enumerator is returned instead.
 */
- (id)rs_downto:(NSInteger)limit do:(void(^)(NSInteger index))block;

/**
 Iterates block, passing in integer values from integer up to and including limit.
 Returns self. If no block is given, an enumerator is returned instead.
 */
- (id)rs_upto:(NSInteger)limit do:(void(^)(NSInteger index))block;


- (NSArray *)rs_to:(NSInteger)to;

@end
