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

- (void)test_concat_when_nil_argument_returns_self {
    id target = @[@1, @2, @3];
    id input = nil;
    id expected = target;
    
    id result = [target:input];
    
    assertThat(result, sameInstance(expected));
}

- (void)test_concat_adds_objects_of_input_array {
    id target = @[@1, @2, @3];
    id input = @[@4, @5, @6];
    id expected = [@1 rs_numbersTo:6];
    
    id result = [target:input];
    
    assertThat(result, hasCountOf([expected count]));
    
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(expected[idx]));
    }];
}

- (void)test_concat_adds_single_objects {
    id target = @[@1, @2, @3];
    id input = @4;
    id expected = [@1 rs_numbersTo:4];
    
    id result = [target:input];
    
    assertThat(result, hasCountOf([expected count]));
    
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(expected[idx]));
    }];
}


- (void)test_shorthand_is_alias_to_keyedSubscript {
    id input = [@0 rs_numbersTo:10];
    id expected = input[@"1..6"];
    
    assertThat([input:1:6], equalTo(expected));
}

- (void)test_shorthand_is_alias_to_keyedSubscript_exclusive {
    id input = [@0 rs_numbersTo:10];
    id expected = input[@"1...6"];
    
    assertThat([input:1:6 exclusive:YES], equalTo(expected));
}

- (void)test_drop {
    id target = [@1 rs_numbersTo:10];
    id expected = [@6 rs_numbersTo:10];
    
    id result = [target rs_drop:5];
    
    assertThat(result, instanceOf([NSArray class]));
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(expected[idx]));
    }];
}

- (void)test_drop_throws_exception_when_out_of_bound {
    id target = [@1 rs_numbersTo:10];
    
    @try {
        [target rs_drop:-3];
    }
    @catch (NSException *exception) {
        assertThat([exception name], equalTo(NSInvalidArgumentException));
        assertThatBool(YES, equalToBool(YES));
        return;
    }
    
    XCTFail(@"Should raise NSInvalidArgumentException exception.");
}

- (void)test_drop_returns_empty_when_count_is_out_of_bound {
    id target = [@1 rs_numbersTo:5];
    assertThat([target rs_drop:10], hasCountOf(0));
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
    id target = [@1 rs_numbersTo:10];
    
    id result = [target rs_dropWhile:nil];
    
    assertThat(result, instanceOf([NSEnumerator class]));
}

- (void)test_join {
    id target = [@1 rs_numbersTo:5];
    id expected = @"1-2-3-4-5";
    
    assertThat([target rs_join:@"-"], equalTo(expected));
}

- (void)test_join_when_separator_nil_an_empty_string_is_used {
    id target = [@1 rs_numbersTo:5];
    id expected = @"12345";
    
    assertThat([target rs_join:nil], equalTo(expected));
}

- (void)test_take {
    id target = [@1 rs_numbersTo:10];
    id expected = [@1 rs_numbersTo:5];
    
    id result = [target rs_take:5];
    
    assertThat(result, instanceOf([NSArray class]));
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(expected[idx]));
    }];
}

- (void)test_take_throws_exception_when_negative {
    id target = [@1 rs_numbersTo:10];
    
    @try {
        [target rs_take:-3];
    }
    @catch (NSException *exception) {
        assertThat([exception name], equalTo(NSInvalidArgumentException));
        assertThatBool(YES, equalToBool(YES));
        return;
    }
    
    XCTFail(@"Should raise NSInvalidArgumentException exception.");
}

- (void)test_take_returns_self_when_count_out_of_bound {
    id target = [@1 rs_numbersTo:5];
    assertThat([target rs_take:10], sameInstance(target));
}

- (void)test_takeWhile {
    id target = [@1 rs_numbersTo:10];
    id expected = [@1 rs_numbersTo:4];
    
    id result = [target rs_takeWhile:^BOOL(id item) {
        return ([item integerValue] < 5);
    }];
    
    assertThat(result, instanceOf([NSArray class]));
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(expected[idx]));
    }];
}

- (void)test_takeWhile_returns_enumerator_when_no_block {
    id target = [@1 rs_numbersTo:10];
    
    id result = [target rs_takeWhile:nil];
    
    assertThat(result, instanceOf([NSEnumerator class]));
}

- (void)test_isEmpty_returns_true {
    assertThatBool([@[] rs_isEmpty], equalToBool(YES));
}

- (void)test_isEmpty_returns_false {
    assertThatBool([@[@1] rs_isEmpty], equalToBool(NO));
}

- (void)test_objectForKeydSubscript_supports_nsnumber {
    id expected = @[@3];
    
    id result = [@0 rs_numbersTo:5][@3];
    
    assertThat(result, equalTo(expected));
}

- (void)test_objectForKeydSubscript_supports_range_exclusive {
    id expected = @[@3, @4];
    
    id result = [@0 rs_numbersTo:5][@"2...5"];
    
    assertThat(result, hasCountOf([expected count]));
    
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(expected[idx]));
    }];
}

- (void)test_objectForKeydSubscript_supports_range_inclusive {
    id expected = @[@2, @3, @4, @5];
    
    id result = [@0 rs_numbersTo:5][@"2..5"];
    
    assertThat(result, hasCountOf([expected count]));
    
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(expected[idx]));
    }];
}


@end
