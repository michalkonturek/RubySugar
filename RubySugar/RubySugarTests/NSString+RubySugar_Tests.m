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

- (void)test_contains_returns_true {
    id input = @"regis";
    
    BOOL result = [@"Vexilla regis." rs_containsString:input];
    
    assertThatBool(result, equalToBool(YES));
}

- (void)test_contains_returns_false {
    id input = @"regiss";
    
    BOOL result = [@"Vexilla regis." rs_containsString:input];
    
    assertThatBool(result, equalToBool(NO));
}

- (void)test_objectAtIndexedSubscript_is_supported {
    id expected = @"e";
    
    id actual = @"Vexilla regis."[1];
    
    assertThat(actual, equalTo(expected));
}

- (void)test_concat_when_nil_argument_returns_self {
    id input = nil;
    id expected = @"Vexilla regis.";
    
    id actual = [expected:input];
    
    assertThat(actual, equalTo(expected));
}

- (void)test_concat_supports_nsstring {
    id input = @" Prodeunt inferni.";
    id expected = @"Vexilla regis. Prodeunt inferni.";
    
    id actual = [@"Vexilla regis.":input];
    
    assertThat(actual, equalTo(expected));
}

- (void)test_concat_supports_nsnumber {
    id input = @100;
    id expected = @"Vexilla regis.100";
    
    id actual = [@"Vexilla regis.":input];
    
    assertThat(actual, equalTo(expected));
}

- (void)test_concat_supports_other_objects {
    id input = @{};
    id expected = @"Vexilla regis.{\n}";
    
    id actual = [@"Vexilla regis.":input];
    
    assertThat(actual, equalTo(expected));
}

- (void)test_shorthand_is_alias_to_keyedSubscript {
    id input = @"Vexilla regis.";
    id expected = input[@"1..6"];
    
    id actual = [input:1:6];
    
    assertThat(actual, equalTo(expected));
}

- (void)test_shorthand_is_alias_to_keyedSubscript_exclusive {
    id input = @"Vexilla regis.";
    id expected = input[@"1...6"];
    
    id actual = [input:1:6 exclusive:YES];
    
    assertThat(actual, equalTo(expected));
}

- (void)test_objectAtIndexedSubscript_returns_nil_when_out_of_range {
    id actual = @"Vexilla regis."[100];
    assertThat(actual, nilValue());
}

- (void)test_objectForKeydSubscript_supports_nsnumber {
    id expected = @"x";
    
    id actual = @"Vexilla regis."[@2];
    
    assertThat(actual, equalTo(expected));
}

- (void)test_objectForKeydSubscript_supports_range_exclusive {
    id expected = @"il";
    
    id actual = @"Vexilla regis."[@"2...5"];
    
    assertThat(actual, equalTo(expected));
}

- (void)test_objectForKeydSubscript_supports_range_inclusive {
    id expected = @"xill";
    
    id actual = @"Vexilla regis."[@"2..5"];
    
    assertThat(actual, equalTo(expected));
}

@end
