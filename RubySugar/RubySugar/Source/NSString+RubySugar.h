//
//  NSString+RubySugar.h
//  RubySugar
//
//  Created by Michal Konturek on 12/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RubySugar)

- (NSString *):(id)object;
- (NSString *):(NSInteger)from :(NSInteger)to;
- (NSString *):(NSInteger)from :(NSInteger)to exclusive:(BOOL)exclusive;

- (NSArray *)rs_chars;

- (BOOL)rs_containsString:(NSString *)term;
- (BOOL)rs_containsString:(NSString *)term caseSensitive:(BOOL)caseSensitive;

- (BOOL)rs_isEmpty;

- (NSString *)rs_justifyLeft:(NSInteger)length;
- (NSString *)rs_justifyLeft:(NSInteger)length with:(NSString *)pad;

- (NSString *)rs_justifyRight:(NSInteger)length;
- (NSString *)rs_justifyRight:(NSInteger)length with:(NSString *)pad;

- (NSArray *)rs_split;
- (NSArray *)rs_split:(NSString *)pattern;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (id)objectForKeyedSubscript:(id<NSCopying>)key;

@end
