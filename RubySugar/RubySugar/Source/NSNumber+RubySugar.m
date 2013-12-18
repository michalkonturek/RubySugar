//
//  NSNumber+RubySugar.m
//  RubySugar
//
//  Created by Michal Konturek on 18/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import "NSNumber+RubySugar.h"

@implementation NSNumber (RubySugar)

- (void)rs_times:(void(^)(void))block {
    NSInteger count = [self integerValue];
    
    for (NSInteger idx = 0; idx < count; idx++) {
        block();
    }
}

- (void)rs_timesWithIndex:(void(^)(NSInteger index))block {
    NSInteger count = [self integerValue];
    
    for (NSInteger idx = 0; idx < count; idx++) {
        block(idx);
    }
}

@end
