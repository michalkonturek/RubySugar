//
//  NSNumber+RubySugar.h
//  RubySugar
//
//  Created by Michal Konturek on 18/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (RubySugar)

//+ (NSArray *):(NSInteger)from :(NSInteger)to;
//+ (NSArray *)rs_from:(NSInteger)from to:(NSInteger)to;

- (void)rs_times:(void(^)(void))block;
- (void)rs_timesWithIndex:(void(^)(NSInteger index))block;

- (void)rs_downto:(NSInteger)limit do:(void(^)(NSInteger index))block;
- (void)rs_upto:(NSInteger)limit do:(void(^)(NSInteger index))block;

- (NSArray *)rs_to:(NSInteger)to;

@end
