//
//  NSArray+RubySugar.h
//  RubySugar
//
//  Created by Michal Konturek on 24/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (RubySugar)

- (instancetype)rs_take;
- (instancetype)rs_takeWhile:(BOOL(^)(id item))block;


@end
