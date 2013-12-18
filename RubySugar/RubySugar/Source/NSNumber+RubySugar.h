//
//  NSNumber+RubySugar.h
//  RubySugar
//
//  Created by Michal Konturek on 18/12/2013.
//  Copyright (c) 2013 Michal Konturek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (RubySugar)

- (void)rs_times:(void(^)(void))block;
- (void)rs_timesWithIndex:(void(^)(NSInteger index))block;

@end
