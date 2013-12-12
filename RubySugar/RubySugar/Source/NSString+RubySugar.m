//
//  NSString+RubySugar.m
//  RubySugar
//
//  Created by Michal Konturek on 12/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import "NSString+RubySugar.h"

@implementation NSString (RubySugar)

- (BOOL)rs_containsString:(NSString *)term {
    return [self rs_containsString:term caseSensitive:YES];
}

- (BOOL)rs_containsString:(NSString *)term caseSensitive:(BOOL)caseSensitive {
    NSString *target = (caseSensitive) ? self : [self lowercaseString];
    NSString *searchTerm = (caseSensitive) ? term : [term lowercaseString];
    NSRange range = [target rangeOfString:searchTerm];
    return (range.location != NSNotFound);
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= [self length]) return nil;
    unichar character = [self characterAtIndex:index];    
    return [NSString stringWithCharacters:&character length:1];
}

- (NSString *):(id)object {
    if (!object) return self;
    
    id result = [NSMutableString stringWithString:self];
    id string = [self _stringValueOf:object];
    [result appendString:string];
    
    return result;
}

- (NSString *)_stringValueOf:(id)object {
    if ([object isKindOfClass:[NSString class]]) return object;
    else if ([object respondsToSelector:@selector(description)]) return [object description];
    else return @"";
}

- (id)objectForKeyedSubscript:(id<NSCopying>)key {
    static NSString *inclusiveRange = @"..";
    static NSString *exclusiveRange = @"...";
    
    if ([(id)key isKindOfClass:[NSString class]]) {
        
        NSRange range = NSRangeFromString((NSString *)key);
        if ([(NSString *)key rs_containsString:exclusiveRange]) {
            range = NSMakeRange(range.location + 1, range.length - range.location - 1);
        } else if ([(NSString *)key rs_containsString:inclusiveRange]) {
            range = NSMakeRange(range.location, range.length - range.location + 1);
        }
        
        return [self substringWithRange:range];
    } if ([(id)key isKindOfClass:[NSValue class]]) {
        
        NSRange range = [(NSValue *)key rangeValue];
        range.length = 1;
        return [self substringWithRange:range];

    } else @throw [NSException exceptionWithName:@"" reason:@"" userInfo:nil];
}


@end
