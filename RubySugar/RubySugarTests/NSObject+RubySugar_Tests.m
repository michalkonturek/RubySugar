//
//  NSObject+RubySugar_Tests.m
//  RubySugar
//
//  Created by Michal Konturek on 22/08/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "NSObject+RubySugar.h"

@interface NSObject_RubySugar_Tests : XCTestCase

@end

@implementation NSObject_RubySugar_Tests

- (void)test_concat_when_nil_argument_returns_array_of_self {
    id target = @1;
    id input = nil;
    id expected = @[target];
    
    id result = [target:input];
    
    assertThat(result, hasCountOf([expected count]));
    assertThat(target, sameInstance(expected[0]));
}

- (void)test_concat_adds_objects_of_input_array {
    id target = @1;
    id input = @[@2, @3, @4];
    id expected = @[@1, @2, @3, @4];
    
    id result = [target:input];

    assertThat(result, hasCountOf([expected count]));
    
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(expected[idx]));
    }];
}

- (void)test_concat_when_target_is_array {
    id target = @[@0, @1];
    id input = @[@2, @3, @4];
    id expected = @[@0, @1, @2, @3, @4];
    
    id result = [target:input];
    
    assertThat(result, hasCountOf([expected count]));
    
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(expected[idx]));
    }];
}

- (void)test_concat_adds_object {
    id target = @1;
    id input = @2;
    id expected = @[@1, @2];
    
    id result = [target:input];
    
    assertThat(result, hasCountOf([expected count]));
    
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(expected[idx]));
    }];
}

@end
