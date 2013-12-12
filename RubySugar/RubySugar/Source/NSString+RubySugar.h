//
//  NSString+RubySugar.h
//  RubySugar
//
//  Created by Michal Konturek on 12/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RubySugar)

- (BOOL)rs_containsString:(NSString *)term;

- (BOOL)rs_containsString:(NSString *)term caseSensitive:(BOOL)caseSensitive;

@end
