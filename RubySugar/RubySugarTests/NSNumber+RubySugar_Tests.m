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

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

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


@end
