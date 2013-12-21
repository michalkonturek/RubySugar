//
//  NSNumber+RubySugar.m
//  RubySugar
//
//  Created by Michal Konturek on 18/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import "NSNumber+RubySugar.h"

@implementation NSNumber (RubySugar)

- (instancetype)rs_gcd:(NSInteger)other {
    if (other == 0) return self;
    return [@(other) rs_gcd:([self integerValue] % other)];
}

- (instancetype)rs_lcm:(NSInteger)other {
    if (([self integerValue] == 0) && (other == 0)) return @0;
    return @(abs([self integerValue] * other) / [[self rs_gcd:other] integerValue]);
}

- (instancetype)rs_next {
    return @([self integerValue] + 1);
}

- (instancetype)rs_pred {
    return @([self integerValue] - 1);
}

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

- (id)rs_downto:(NSInteger)limit do:(void(^)(NSInteger index))block {
    if (!block) return [self rs_downto:limit];
    if ([self integerValue] < limit) return self;
    
    for (id item in [self rs_downto:limit]) {
        block([item integerValue]);
    }
    
    return self;
}

- (id)rs_upto:(NSInteger)limit do:(void(^)(NSInteger index))block {
    if (!block) return [self rs_upto:limit];
    if ([self integerValue] > limit) return self;
    
    for (id item in [self rs_upto:limit]) {
        block([item integerValue]);
    }
    
    return self;
}

- (NSEnumerator *)rs_downto:(NSInteger)limit {
    return [[self rs_to:limit] objectEnumerator];
}

- (NSEnumerator *)rs_upto:(NSInteger)limit {
    return [[self rs_to:limit] objectEnumerator];
}

- (NSArray *)rs_to:(NSInteger)to {
    NSInteger from = [self integerValue];
    if (from == to) return [NSArray array];
    
    NSInteger range = labs(from - to) + 1;
    NSInteger step = (from < to) ? 1 : -1;
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:range];
    for (NSInteger i = 0; i < range; i++) {
        [result addObject:[NSNumber numberWithInteger:from]];
        from += step;
    }
    
    return result;
}

@end
