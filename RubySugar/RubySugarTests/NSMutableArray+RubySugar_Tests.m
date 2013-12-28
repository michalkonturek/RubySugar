//
//  NSMutableArray+RubySugar_Tests.m
//  RubySugar
//
//  Created by Michal Konturek on 26/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "NSMutableArray+RubySugar.h"

@interface NSMutableArray_RubySugar_Tests : XCTestCase

@end

@implementation NSMutableArray_RubySugar_Tests

- (void)test_clear_removes_all_objects {
    id target = [@[@1, @2, @3] mutableCopy];
    
    id result = [target rs_clear];
    
    assertThat(result, hasCountOf(0));
}

- (void)test_delete_returns_self_when_no_matching_item {
    id target = [@[@1, @2, @3] mutableCopy];
    id result = [target rs_delete:@4];
    assertThat(result, sameInstance(target));
}

- (void)test_delete_returns_array_without_objects_equal_to_removed {
    id target = [@[@1, @1, @2, @3] mutableCopy];
    id expected = @[@2, @3];
    id input = @1;
    
    id result = [target rs_delete:input];
    
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
}

- (void)test_deleteAt_returns_self_when_index_out_of_range {
    id target = [@[@1, @2, @3] mutableCopy];
    id result = [target rs_deleteAt:100];
    assertThat(result, sameInstance(target));
}

- (void)test_deleteAt_retruns_array_without_deleted_object {
    id target = [@[@0, @1, @2, @3] mutableCopy];
    id expected = @[@0, @2, @3];
    NSInteger input = 1;
    
    id result = [target rs_deleteAt:input];
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
}

- (void)test_deleteAt_supports_negative_index {
    id target = [@[@0, @1, @2, @3, @4] mutableCopy];
    id expected = @[@0, @1, @2, @3];
    NSInteger input = -1;
    
    id result = [target rs_deleteAt:input];
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
}

- (void)test_deleteIf_returns_enumerator_when_block_is_nil {
    id result = [[NSMutableArray array] rs_deleteIf:nil];
    assertThat(result, instanceOf([NSEnumerator class]));
}

- (void)test_deleteIf_returns_array_without_deleted_objects {
    id target = [@[@0, @1, @2, @3, @4] mutableCopy];
    id expected = @[@0, @1, @2];
    
    id result = [target rs_deleteIf:^BOOL(id item) {
        return ([item integerValue] > 2);
    }];
    
    [expected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        assertThat(obj, equalTo(result[idx]));
    }];
}

@end
