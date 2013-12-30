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

- (void)test_clear {
    id target = @[@1, @2];
    assertThat([target rs_clear], hasCountOf(0));
}

- (void)test_compact {
    id target = @[@1, [NSNull null], @3, @"w", [NSNull null], @"!"];
    id expected = @[@1, @3, @"w", @"!"];
    
    id result = [target rs_compact];
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
    
    assertThat(result, hasCountOf([expected count]));
}

- (void)test_delete_returns_self_when_no_matching_item {
    id target = @[@1, @2, @3];
    id result = [target rs_delete:@4];
    assertThat(result, sameInstance(target));
}

- (void)test_delete_returns_array_without_objects_equal_to_removed {
    id target = @[@1, @1, @2, @3];
    id expected = @[@2, @3];
    id input = @1;
    
    id result = [target rs_delete:input];
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
}

- (void)test_deleteAt_returns_self_when_index_out_of_range {
    id target = @[@1, @2, @3];
    id result = [target rs_deleteAt:100];
    assertThat(result, sameInstance(target));
}

- (void)test_deleteAt_retruns_array_without_deleted_object {
    id target = @[@0, @1, @2, @3];
    id expected = @[@0, @2, @3];
    NSInteger input = 1;
    
    id result = [target rs_deleteAt:input];
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
}

- (void)test_deleteAt_supports_negative_index {
    id target = @[@0, @1, @2, @3, @4];
    id expected = @[@0, @1, @2, @3];
    NSInteger input = -1;
    
    id result = [target rs_deleteAt:input];
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
}

- (void)test_deleteIf_returns_enumerator_when_block_is_nil {
    id result = [@[] rs_deleteIf:nil];
    assertThat(result, instanceOf([NSEnumerator class]));
}

- (void)test_deleteIf_returns_array_without_deleted_objects {
    id target = @[@0, @1, @2, @3, @4];
    id expected = @[@0, @1, @2];
    
    id result = [target rs_deleteIf:^BOOL(id item) {
        return ([item integerValue] > 2);
    }];
    
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
}

- (void)test_drop {
    id target = [@1 rs_numbersTo:10];
    id expected = [@6 rs_numbersTo:10];
    
    id result = [target rs_drop:5];
    
    assertThat(result, instanceOf([NSArray class]));
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
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
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
}

- (void)test_dropWhile_returns_enumerator_when_no_block {
    id target = [@1 rs_numbersTo:10];
    
    id result = [target rs_dropWhile:nil];
    
    assertThat(result, instanceOf([NSEnumerator class]));
}

- (void)test_fetch_mirrors_objectAtIndex {
    id target = @[@1, @2, @3];
    assertThat([target rs_fetch:1], equalTo([target objectAtIndex:1]));
}

- (void)test_flatten {
    id target = @[@1, @2, @[@3, @4, @[@5, @6]]];
    id expected = @[@1, @2, @3, @4, @5, @6];
    
    id result = [target rs_flatten];
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            assertThat(obj, equalTo(result[idx]));
        }];
    
    assertThat(result, hasCountOf([expected count]));
}

- (void)test_flatten_when_level_1 {
    id target = @[@1, @2, @[@3, @4, @[@5, @6]]];
    id expected = @[@1, @2, @3, @4, @[@5, @6]];
    
    id result = [target rs_flatten:1];
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
    
    assertThat(result, hasCountOf([expected count]));
}

- (void)test_includes_mirrors_containsObject {
    id target = @[@1, @2, @3];
    assertThatBool([target rs_includes:@2], equalToBool([target containsObject:@2]));
}

- (void)test_isEmpty_returns_true {
    assertThatBool([@[] rs_isEmpty], equalToBool(YES));
}

- (void)test_isEmpty_returns_false {
    assertThatBool([@[@1] rs_isEmpty], equalToBool(NO));
}

- (void)test_join {
    id target = [@1 rs_numbersTo:5];
    id expected = @"1-2-3-4-5";
    
    assertThat([target rs_join:@"-"], equalTo(expected));
}

- (void)test_join_when_separator_nil_an_empty_string_is_used {
    id target = [@1 rs_numbersTo:5];
    id expected = @"12345";
    
    assertThat([target rs_join], equalTo(expected));
}

- (void)test_permutation_returns_empty_when_n_is_zero {
    id target = @[@1, @2, @3];
    id result = [target rs_permutation:0];
    assertThat(result, hasCountOf(0));
}

- (void)test_permutation {
    id target = @[@1, @2, @3];
    id expected = @[@[@1, @2, @3],
                    @[@1, @3, @2],
                    @[@2, @1, @3],
                    @[@2, @3, @1],
                    @[@3, @1, @2],
                    @[@3, @2, @1]] ;
    
    id result = [target rs_permutation];
    
    NSInteger match = 0;
    for (id permutation in expected) {
        for (id item in result) {
            if ([item isEqualToArray:permutation]) {
                match++;
                break;
            };
        }
    }
  
    assertThatInteger(match, equalToInteger([expected count]));
}

- (void)test_reverse {
    id target = [@1 rs_numbersTo:5];
    id expected = [@5 rs_numbersTo:1];
    
    id result = [target rs_reverse];
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
    assertThat(result, hasCountOf([expected count]));
}

- (void)test_sample_returns_nil_when_array_is_empty {
    assertThat([@[] rs_sample], nilValue());
}

- (void)test_sample_returns_an_element {
    id target = @[@1, @2, @"s", @3];
    
    id result = [target rs_sample];

    assertThat(result, isNot(nilValue()));
    assertThat(target, hasItem(result));
}

- (void)test_sample_with_param_returns_empty_array_when_empty {
    assertThat([@[] rs_sample:1], equalTo(@[]));
}

- (void)test_sample_with_param_returns_n_elements {
    id target = @[@1, @2, @"s", @3, @4];
    NSInteger input = 3;
    
    id result = [target rs_sample:input];
    
    assertThat(result, hasCountOf(input));
    for (id item in result) {
        assertThat(target, hasItem(item));
    }
}

- (void)test_sample_with_param_returns_all_elements_when_n_larger_than_count {
    id target = @[@1, @2, @"s", @3, @4];
    NSInteger input = 100;
    
    id result = [target rs_sample:input];
    
    assertThat(result, hasCountOf([target count]));
    for (id item in result) {
        assertThat(target, hasItem(item));
    }
}

- (void)test_shuffle {
//    id target = @[@1, @2, @3];
//    id expected = @[@[@1, @2, @3],
//                    @[@1, @3, @2],
//                    @[@2, @1, @3],
//                    @[@2, @3, @1],
//                    @[@3, @1, @2],
//                    @[@3, @2, @1]] ;
//
//    id result = nil;
//    while (YES) {
//        result = [target rs_shuffle];
//        if (![result isEqualToArray:target]) break;
//    }
//
//    BOOL success = NO;
//    for (id permutation in expected) {
//        if ([result isEqualToArray:permutation]) {
//            success = YES;
//            break;
//        }
//    }
//    
//    assertThatBool(success, equalToBool(YES));
}

- (void)test_take {
    id target = [@1 rs_numbersTo:10];
    id expected = [@1 rs_numbersTo:5];
    
    id result = [target rs_take:5];
    
    assertThat(result, instanceOf([NSArray class]));
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
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
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
}

- (void)test_takeWhile_returns_enumerator_when_no_block {
    id target = [@1 rs_numbersTo:10];
    
    id result = [target rs_takeWhile:nil];
    
    assertThat(result, instanceOf([NSEnumerator class]));
}

- (void)test_uniq {
    id target = @[@1, @2, @1, @"w", @"a", @"w"];
    id expected = @[@1, @2, @"a", @"w"];
    
    id result = [target rs_uniq];
    
    assertThat(result, hasCountOf([expected count]));
    assertThat(result, containsInAnyOrder(@1, @2, @"a", @"w", nil));
}

- (void)test_uniq_with_block {
    id target = @[@[@"student", @"sam"], @[@"student", @"george"], @[@"teacher", @"matz"]];
    id expected = @[@[@"student", @"sam"] , @[@"teacher", @"matz"]];
    
    id result = [target rs_uniq:^id(id item) {
        return [item firstObject];
    }];
    
    assertThat(result, hasCountOf([expected count]));
    assertThat(result, containsInAnyOrder(@[@"student", @"sam"] , @[@"teacher", @"matz"], nil));
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
    
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
}

- (void)test_objectForKeydSubscript_supports_range_inclusive {
    id expected = @[@2, @3, @4, @5];
    
    id result = [@0 rs_numbersTo:5][@"2..5"];
    
    assertThat(result, hasCountOf([expected count]));
    
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
}

@end
