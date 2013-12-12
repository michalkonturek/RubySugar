//
//  NSString+RubySugar_Tests.m
//  RubySugar
//
//  Created by Michal Konturek on 12/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "NSString+RubySugar.h"

@interface NSString_RubySugar_Tests : XCTestCase

@end

@implementation NSString_RubySugar_Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}


- (void)test_contains_returns_true {
    
}

- (void)test_contains_returns_false {
    
}

- (void)test_subscript {
    id input = @"Vexilla regis.";
    id expected = @"xil";
    
    id actual = input[@"2..4"];
    
    assertThat(actual, equalTo(expected));
}

- (void)test_subscript_when_range_inclusive {
    id input = @"Vexilla regis.";
    id expected = @"xil";
    
    id actual = input[@"2..4"];
    
    assertThat(actual, equalTo(expected));
}

- (void)test_subscript_when_range_exclusive {
    id input = @"Vexilla regis.";
    id expected = @"xil";
    
    id actual = input[@1];
    
    assertThat(actual, equalTo(expected));
}

@end
