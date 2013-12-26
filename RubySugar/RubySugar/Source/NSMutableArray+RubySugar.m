//
//  NSMutableArray+RubySugar.m
//  RubySugar
//
//  Created by Michal Konturek on 26/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import "NSMutableArray+RubySugar.h"

@implementation NSMutableArray (RubySugar)

- (instancetype)rs_clear {
    [self removeAllObjects];
    return self;
}

@end
