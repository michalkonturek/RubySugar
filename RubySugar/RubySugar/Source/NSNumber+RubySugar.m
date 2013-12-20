//
//  NSNumber+RubySugar.m
//  RubySugar
//
//  Created by Michal Konturek on 18/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import "NSNumber+RubySugar.h"

@implementation NSNumber (RubySugar)

//+ (NSArray *):(NSInteger)from :(NSInteger)to {
//    return [self rs_from:from to:to];
//}
//
//+ (NSArray *)rs_from:(NSInteger)from to:(NSInteger)to {
//    return [@(from) rs_to:to];
//}

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

- (void)rs_downto:(NSInteger)limit do:(void(^)(NSInteger index))block {
    
}

- (void)rs_upto:(NSInteger)limit do:(void(^)(NSInteger index))block {
    
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
