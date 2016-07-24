//
//  NSSet+Fn.m
//  CocoaFn
//
//  Created by Kazuki Murakami on 7/24/16.
//  Copyright © 2016 Himajinworks. All rights reserved.
//

#import "NSSet+Fn.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSSet (Fn)

- (void)each:(void (^)(id _Nonnull))fn
{
  [self enumerateObjectsUsingBlock:^(id _Nonnull obj, BOOL * _Nonnull stop) {
    fn(obj);
  }];
}

- (NSSet *)map:(id  _Nonnull (^)(id _Nonnull))fn
{
  __block NSMutableSet *set = [NSMutableSet setWithCapacity:0];

  [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
    [set addObject:fn(obj)];
  }];

  return [set copy];
}

- (id)reduce:(id)initial fn:(id  _Nonnull (^)(id _Nonnull, id _Nonnull))fn
{
  __block id current = initial;

  [self enumerateObjectsUsingBlock:^(id _Nonnull obj, BOOL * _Nonnull stop) {
    current = fn(current, obj);
  }];

  return current;
}

- (NSSet *)select:(BOOL (^)(id _Nonnull))fn
{
  __block NSMutableSet *set = [NSMutableSet setWithCapacity:0];

  [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
    if (fn(obj)) {
      [set addObject:obj];
    }
  }];

  return [set copy];
}

- (NSSet *)reject:(BOOL (^)(id _Nonnull))fn
{
  return [self select:^BOOL(id  _Nonnull element) {
    return !fn(element);
  }];
}

@end

NS_ASSUME_NONNULL_END