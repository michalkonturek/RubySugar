# RubySugar

[![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)](https://github.com/michalkonturek/RubySugar/blob/master/LICENSE)
[![Build Platform](https://cocoapod-badges.herokuapp.com/p/RubySugar/badge.png)](https://github.com/michalkonturek/RubySugar)
[![Build Version](https://cocoapod-badges.herokuapp.com/v/RubySugar/badge.png)](https://github.com/michalkonturek/RubySugar)
<!--[![Build Status](https://travis-ci.org/michalkonturek/RubySugar.png?branch=master)](https://travis-ci.org/michalkonturek/RubySugar)-->

## Intro

Ports Ruby syntactic sugar to Objective-C.

## License

Source code of this project is available under the standard MIT license. Please see [the license file][LICENSE].

[PODS]:http://cocoapods.org/
[LICENSE]:https://github.com/michalkonturek/RubySugar/blob/master/LICENSE

# API

## NSArray

```obj-c
```

## NSString

```obj-c
- (NSString *):(id)object;

- (NSString *):(NSInteger)from :(NSInteger)to;

- (NSString *):(NSInteger)from :(NSInteger)to exclusive:(BOOL)exclusive;

- (BOOL)rs_containsString:(NSString *)term;

- (BOOL)rs_containsString:(NSString *)term caseSensitive:(BOOL)caseSensitive;

- (NSString *)rs_justifyLeft:(NSInteger)length;

- (NSString *)rs_justifyLeft:(NSInteger)length with:(NSString *)pad;

- (NSString *)rs_justifyRight:(NSInteger)length;

- (NSString *)rs_justifyRight:(NSInteger)length with:(NSString *)pad;

- (id)objectAtIndexedSubscript:(NSUInteger)index;

- (id)objectForKeyedSubscript:(id<NSCopying>)key;
```

## NSNumber

 
```objc
- (instancetype)rs_gcd:(NSInteger)other;

/*
 Returns the greatest common divisor (always positive).
 */

id result = [@15 rs_gcd:3];
// => 3
```


```objc
- (instancetype)rs_lcm:(NSInteger)other;

/*
 Returns the least common multiple (always positive).
 */
 
id result = [@5 rs_lcm:3];
// => 15
```


```objc
- (instancetype)rs_next;

/*
 Returns successor integer, i.e. i + 1.
 */

[@1 rs_next];
// => 2
```


```objc
- (instancetype)rs_pred;

/*
 Returns predecessor integer, i.e. i - 1.
 */

[@1 rs_pred];
// => 0
```


```objc
- (id)rs_times:(void(^)(void))block;

/*
 Iterates block n times, passing in values from zero to (n - 1).
 Returns self. If no block is given, an enumerator is returned instead.
 */

__block NSInteger result = 0;
[@5 rs_times:^{
    result += 2;
}];
// => @5
// result => 10
```


```objc
- (id)rs_timesWithIndex:(void(^)(NSInteger index))block;

/*
 Iterates block n times, passing in values from zero to (n - 1).
 Returns self. If no block is given, an enumerator is returned instead.
 */
 
__block NSMutableArray *result = [NSMutableArray array];
[@5 rs_timesWithIndex:^(NSInteger index) {
    [result addObject:@(index)];
}];
// => 5
// result => [@0, @1, @2, @3, @4,]
```


```objc
- (id)rs_downto:(NSInteger)limit do:(void(^)(NSInteger index))block;

/*
 Iterates block, passing decreasing values from integer down to and including limit.
 Returns self. If no block is given, an enumerator is returned instead.
 */

[@3 rs_downto:1 do:^(NSInteger index) {
	NSLog(@"Line %i...", index);
}];
// => 3
// Line 3...
// Line 2...
// Line 1...
```
 

```objc
-(id)rs_upto:(NSInteger)limit do:(void(^)(NSInteger index))block;

/*
 Iterates block, passing in integer values from integer up to and including limit.
 Returns self. If no block is given, an enumerator is returned instead.
 */

[@1 rs_upto:3 do:^(NSInteger index) {
	NSLog(@"Line %i...", index);
}];
// => 1
// Line 1...
// Line 2...
// Line 3...
```


```objc
- (NSArray *)rs_numbersTo:(NSInteger)to;

/*
Creates array with integers between from and to inclusively.
*/

id numbers = [@1 rs_numbersTo:10];
// => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```


- - -

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/michalkonturek/rubysugar/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
