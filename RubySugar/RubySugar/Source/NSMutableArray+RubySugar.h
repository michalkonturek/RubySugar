//
//  NSMutableArray+RubySugar.h
//  RubySugar
//
//  Created by Michal Konturek on 26/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSArray+RubySugar.h"

@interface NSMutableArray (RubySugar)

/**
 Removes all elements from self.
 */
- (instancetype)rs_clear;

@end
