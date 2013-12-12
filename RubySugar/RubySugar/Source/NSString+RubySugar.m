//
//  NSString+RubySugar.m
//  RubySugar
//
//  Created by Michal Konturek on 12/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import "NSString+RubySugar.h"

@implementation NSString (RubySugar)

- (BOOL)containsString:(NSString *)term {
    return [self containsString:term caseSensitive:YES];
}

- (BOOL)containsString:(NSString *)term caseSensitive:(BOOL)caseSensitive {
    NSString *target = (caseSensitive) ? self : [self lowercaseString];
    NSString *searchTerm = (caseSensitive) ? term : [term lowercaseString];
    NSRange range = [target rangeOfString:searchTerm];
    return (range.location != NSNotFound);
}


- (id)objectForKeyedSubscript:(id<NSCopying>)key {
    return nil;
}


@end
