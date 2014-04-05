//
//  NSString+RubySugar_Tests.m
//  RubySugar
//
//  Copyright (c) 2013 Michal Konturek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "NSString+RubySugar.h"

@interface NSString_RubySugar_Tests : XCTestCase

@end

@implementation NSString_RubySugar_Tests

- (void)test_chars {
    id input = @"abcdef";
    assertThat([input rs_chars], contains(@"a", @"b", @"c", @"d", @"e", @"f", nil));
}

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

- (void)test_delete_supports_string_input {
    id input = @"l";
    assertThat([@"hello" rs_delete:input], equalTo(@"heo"));
}

- (void)test_delete_supports_array_input {
    id input = @[@"l", @"o"];
    assertThat([@"hello" rs_delete:input], equalTo(@"he"));
}

- (void)test_delete_supports_set_input {
    id input = [NSSet setWithArray:@[@"l", @"o"]];
    assertThat([@"hello" rs_delete:input], equalTo(@"he"));
}

- (void)test_delete_supports_dictionary_input {
    id input = @{@1: @"l", @2: @"o"};
    assertThat([@"hello" rs_delete:input], equalTo(@"he"));
}

- (void)test_delete_when_not_supported_type_returns_self {
    id target = @"hello";
    assertThat([target rs_delete:@1], equalTo(target));
}

- (void)test_eachChar {
    id input = @"abcdef";
    
    id result = [NSMutableString string];
    [input rs_eachChar:^(NSString *item) {
        [result appendString:item];
    }];
    
    assertThat(result, equalTo(input));
}

- (void)test_eachChar_when_block_is_given_returns_self {
    id input = @"abcdef";
    
    id result = [input rs_eachChar:^(NSString *item) {}];
    
    assertThat(result, equalTo(input));
}

- (void)test_eachChar_when_no_block_is_given_returns_enumerator {
    id input = @"abcdef";
    
    id result = [input rs_eachChar:nil];
    
    assertThat(result, instanceOf([NSEnumerator class]));
    
    NSInteger idx = 0;
    for (id item in result) {
        assertThat(item, equalTo(input[idx]));
        idx++;
    }
}

- (void)test_isEmpty_returns_true {
    id input = @"";
    assertThatBool([input rs_isEmpty], equalToBool(YES));
}

- (void)test_isEmpty_returns_false {
    id input = @"A";
    assertThatBool([input rs_isEmpty], equalToBool(NO));
}

- (void)test_justifyLeft_when_length_not_greater_than_current_returns_self {
    id input = @"Justify me";
    id expected = input;
    
    id result = [input rs_justifyLeft:5];
    
    assertThat(result, sameInstance(expected));
}

- (void)test_justifyLeft_when_no_pad_specified_returns_padded_string_with_whitespaces {
    id input = @"Justify me";
    id expected = @"Justify me     ";
    
    id result = [input rs_justifyLeft:15];
    
    assertThat(result, equalTo(expected));
}

- (void)test_justifyLeft_when_pad_specified_returns_padded_string_with_specified_pad {
    id input = @"Justify me";
    id expected = @"Justify me!!!!!";
    
    id result = [input rs_justifyLeft:15 with:@"!"];
    
    assertThat(result, equalTo(expected));
}

- (void)test_justifyRight_when_length_not_greater_than_current_returns_self {
    id input = @"Justify me";
    id expected = input;
    
    id result = [input rs_justifyRight:5];
    
    assertThat(result, sameInstance(expected));
}

- (void)test_justifyRight_when_no_pad_specified_returns_padded_string_with_whitespaces {
    id input = @"Justify me";
    id expected = @"     Justify me";

    id result = [input rs_justifyRight:15];
    
    assertThat(result, equalTo(expected));
}

- (void)test_justifyRight_when_pad_specified_returns_padded_string_with_specified_pad {
    id input = @"Justify me";
    id expected = @"!!!!!Justify me";
    
    id result = [input rs_justifyRight:15 with:@"!"];
    
    assertThat(result, equalTo(expected));
}

- (void)test_split_when_nil_pattern_it_divides_on_whitespaces {
    id input = @"Split me";
    
    id result = [input rs_split:nil];
    assertThat(result, contains(@"Split", @"me", nil));
}

- (void)test_split_divides_on_character {
    id input = @"! Split!me!good!";
    
    id result = [input rs_split:@"!"];
    assertThat(result, contains(@" Split", @"me", @"good", nil));
}

- (void)test_split_when_empty_pattern_it_divides_by_character {
    id input = @"Hello";
    
    id result = [input rs_split:@""];
    assertThat(result, contains(@"H", @"e", @"l", @"l", @"o", nil));
}

- (void)test_strip_contains_whitespaces_and_newlines {
    id input = @"\t    goodbye\r\n";
    id expected = @"goodbye";

    id result = [input rs_strip];
    assertThat(result, equalTo(expected));
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
