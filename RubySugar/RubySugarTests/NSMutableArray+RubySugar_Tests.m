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
    id target = [NSMutableArray arrayWithArray:@[@1, @2, @3]];
    
    id result = [target rs_clear];
    
    assertThat(result, hasCountOf(0));
}




@end
