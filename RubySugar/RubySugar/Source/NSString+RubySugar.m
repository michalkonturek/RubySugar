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
    static NSString *inclusiveRange = @"..";
    static NSString *exclusiveRange = @"...";
    
    if ([(id)key isKindOfClass:[NSString class]]) {
        
        NSRange range = NSRangeFromString((NSString *)key);
        if ([(NSString *)key containsString:exclusiveRange]) {
            range = NSMakeRange(range.location + 1, range.length - range.location - 1);
        } else if ([(NSString *)key containsString:inclusiveRange]) {
            range = NSMakeRange(range.location, range.length - range.location + 1);
        }
        
        return [self substringWithRange:range];
    }
    else @throw [NSException exceptionWithName:@"" reason:@"" userInfo:nil];
}


@end
