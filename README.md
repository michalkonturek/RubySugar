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

```obj-c
- (void)rs_times:(void(^)(void))block;
- (void)rs_timesWithIndex:(void(^)(NSInteger index))block;
```

- - -

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/michalkonturek/rubysugar/trend.png)](https://bitdeli.com/free "Bitdeli Badge")