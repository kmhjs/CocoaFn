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

#pragma mark - Property based access

- (void (^)(SetVoidFnBlock))each
{
  return ^(SetVoidFnBlock fn) {
    return [self each:fn];
  };
}

- (NSSet *(^)(SetIdFnBlock))map
{
  return ^NSSet *(SetIdFnBlock fn) {
    return [self map:fn];
  };
}

- (id (^)(id, SetReduceFnBlock))reduce
{
  return ^id(id initial, SetReduceFnBlock fn) {
    return [self reduce:initial fn:fn];
  };
}

- (NSSet<id> *(^)(SetBoolFnBlock))select
{
  return ^NSSet *(SetBoolFnBlock fn) {
    return [self select:fn];
  };
}

- (NSSet<id> *(^)(SetBoolFnBlock))reject
{
  return ^NSSet *(SetBoolFnBlock fn) {
    return [self reject:fn];
  };
}

@end

NS_ASSUME_NONNULL_END