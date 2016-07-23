//
//  NSDictionary+Fn.m
//  CocoaFn
//
//  Created by Kazuki Murakami on 7/23/16.
//  Copyright © 2016 Himajinworks. All rights reserved.
//

#import "NSDictionary+Fn.h"

@implementation NSDictionary (Fn)

- (void)each:(void (^)(id key, id value))fn
{
  [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
    fn(key, obj);
  }];
}

- (NSDictionary *)map:(id (^)(id key, id value))fn
{
  __block NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];

  [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
    [dict setObject:fn(key, obj) forKey:key];
  }];

  return [dict copy];
}

- (id)reduce:(id)initial fn:(id (^)(id, id, id))fn
{
  __block id current = initial;

  [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
    current = fn(current, key, obj);
  }];

  return current;
}

- (NSDictionary *)select:(BOOL (^)(id, id))fn
{
  __block NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];

  [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
    if (fn(key, obj)) {
      [dict setObject:obj forKey:key];
    }
  }];

  return [dict copy];
}

- (NSDictionary *)reject:(BOOL (^)(id, id))fn
{
  return [self select:^BOOL(id key, id value) {
    return !fn(key, value);
  }];
}

@end
