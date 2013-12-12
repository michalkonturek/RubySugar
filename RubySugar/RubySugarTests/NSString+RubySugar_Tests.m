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

@property (nonatomic, strong) NSString *target;

@end

@implementation NSString_RubySugar_Tests

- (void)setUp {
    [super setUp];
    self.target = @"Vexilla regis prodeunt inferni.";
}

- (void)tearDown {
    self.target = nil;
    [super tearDown];
}


- (void)test_contains_returns_true {
    id input = @"regis";
    
    BOOL result = [self.target rs_containsString:input];
    
    assertThatBool(result, equalToBool(YES));
}

- (void)test_contains_returns_false {
    id input = @"regiss";
    
    BOOL result = [self.target rs_containsString:input];
    
    assertThatBool(result, equalToBool(NO));
}

- (void)test_subscript_supports_numbers {
    id input = @"Vexilla regis.";
    id expected = @"x";
    
    id actual = input[@2];
    
    assertThat(actual, equalTo(expected));
}

- (void)test_subscript_when_range_exclusive {
    id input = @"Vexilla regis.";
    id expected = @"il";
    
    id actual = input[@"2...5"];
    
    assertThat(actual, equalTo(expected));
}

- (void)test_subscript_when_range_inclusive {
    id input = @"Vexilla regis.";
    id expected = @"xill";
    
    id actual = input[@"2..5"];
    
    assertThat(actual, equalTo(expected));
}

@end
