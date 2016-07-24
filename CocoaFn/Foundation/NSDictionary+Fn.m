//
//  NSDictionary+Fn.m
//  CocoaFn
//
//  Created by Kazuki Murakami on 7/23/16.
//  Copyright © 2016 Himajinworks. All rights reserved.
//

#import "NSDictionary+Fn.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSDictionary (Fn)

- (void)each:(DictionaryVoidFnBlock)fn
{
  [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
    fn(key, obj);
  }];
}

- (NSDictionary *)map:(DictionaryIdFnBlock)fn
{
  __block NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];

  [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
    [dict setObject:fn(key, obj) forKey:key];
  }];

  return [dict copy];
}

- (id)reduce:(id)initial fn:(DictionaryReduceFnBlock)fn
{
  __block id current = initial;

  [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
    current = fn(current, key, obj);
  }];

  return current;
}

- (NSDictionary *)select:(DictionaryBoolFnBlock)fn
{
  __block NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];

  [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
    if (fn(key, obj)) {
      [dict setObject:obj forKey:key];
    }
  }];

  return [dict copy];
}

- (NSDictionary *)reject:(DictionaryBoolFnBlock)fn
{
  return [self select:^BOOL(id key, id value) {
    return !fn(key, value);
  }];
}

#pragma mark - Property based access

- (void (^)(DictionaryVoidFnBlock))each
{
  return ^(DictionaryVoidFnBlock fn) {
    return [self each:fn];
  };
}

- (NSDictionary *(^)(DictionaryIdFnBlock))map {
  return ^NSDictionary *(DictionaryIdFnBlock fn) {
    return [self map:fn];
  };
}

- (id (^)(id, DictionaryReduceFnBlock))reduce
{
  return ^id(id initial, DictionaryReduceFnBlock fn) {
    return [self reduce:initial fn:fn];
  };
}

- (NSDictionary<id, id> *(^)(DictionaryBoolFnBlock))select
{
  return ^NSDictionary *(DictionaryBoolFnBlock fn) {
    return [self select:fn];
  };
}

- (NSDictionary<id, id> *(^)(DictionaryBoolFnBlock))reject
{
  return ^NSDictionary *(DictionaryBoolFnBlock fn) {
    return [self reject:fn];
  };
}

@end

NS_ASSUME_NONNULL_END