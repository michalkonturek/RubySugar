//
//  NSNumber+RubySugar_Tests.m
//  RubySugar
//
//  Created by Michal Konturek on 18/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "NSNumber+RubySugar.h"

@interface NSNumber_RubySugar_Tests : XCTestCase

@end

@implementation NSNumber_RubySugar_Tests

- (void)test_times_when_zero_or_lower_does_nothing {
    id input = @0;
    id expected = @0;
    
    __block NSInteger result = 0;
    [input rs_times:^{
        result += 1;
    }];
    
    assertThat(@(result), equalTo(expected));
}

- (void)test_times {
    id input = @5;
    id expected = @5;
    
    __block NSInteger result = 0;
    [input rs_times:^{
        result += 1;
    }];
    
    assertThat(@(result), equalTo(expected));
}

- (void)test_timesWithIndex_when_zero_or_lower_does_nothing {
    id input = @0;
    id expected = @0;
    
    __block NSInteger result = 0;
    [input rs_timesWithIndex:^(NSInteger index) {
        result += index;
    }];
    
    assertThat(@(result), equalTo(expected));
}

- (void)test_timesWithIndex {
    id input = @5;
    id expected = @5;
    
    __block NSMutableArray *result = [NSMutableArray array];
    [input rs_timesWithIndex:^(NSInteger index) {
        [result addObject:@(index)];
    }];
    
    assertThat(result, hasCountOf([expected integerValue]));
    assertThat(result, onlyContains(@0, @1, @2, @3, @4, nil));
}

- (void)test_to_when_from_low_to_high {
    id result = [@1 rs_to:10];
    assertThat(result, contains(@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, nil));
}

- (void)test_to_when_from_high_to_low {
    id result = [@10 rs_to:1];
    assertThat(result, contains(@10, @9, @8, @7, @6, @5, @4, @3, @2, @1, nil));
}

- (void)test_downto_when_no_block_is_given_returns_enumerator {
    
}


@end
