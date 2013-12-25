//
//  NSArray+RubySugar_Tests.m
//  RubySugar
//
//  Created by Michal Konturek on 24/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "NSArray+RubySugar.h"
#import "NSNumber+RubySugar.h"

@interface NSArray_RubySugar_Tests : XCTestCase

@end

@implementation NSArray_RubySugar_Tests

- (void)test_drop {
    id target = [@1 rs_numbersTo:10];
    id expected = [@6 rs_numbersTo:10];
    
    id result = [target rs_drop:5];
    
    assertThat(result, instanceOf([NSArray class]));
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(expected[idx]));
    }];
}

- (void)test_drop_throws_exception_when_negative {
    id target = [@1 rs_numbersTo:10];
    
    @try {
        [target rs_drop:-1];
    }
    @catch (NSException *exception) {
        assertThat([exception name], equalTo(NSInvalidArgumentException));
        assertThatBool(YES, equalToBool(YES));
        return;
    }
    
    XCTFail(@"Should raise exception.");
}

- (void)test_dropWhile {
    id target = [@1 rs_numbersTo:10];
    id expected = [@5 rs_numbersTo:10];
    
    id result = [target rs_dropWhile:^BOOL(id item) {
        return ([item integerValue] < 5);
    }];
    
    assertThat(result, instanceOf([NSArray class]));
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(expected[idx]));
    }];
}

- (void)test_dropWhile_returns_enumerator_when_no_block {
    
}

@end
