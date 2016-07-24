//
//  NSArray+Fn.m
//  CocoaFn
//
//  Created by Kazuki Murakami on 7/23/16.
//  Copyright © 2016 Himajinworks. All rights reserved.
//

#import "NSArray+Fn.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSArray (Fn)

- (void)each:(ArrayVoidFnBlock)fn
{
  [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    fn(obj);
  }];
}

- (NSArray *)map:(ArrayIdFnBlock)fn
{
  __block NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];

  [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [arr addObject:fn(obj)];
  }];

  return [arr copy];
}

- (id)reduce:(id)initial fn:(ArrayReduceFnBlock)fn
{
  __block id current = initial;

  [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    current = fn(current, obj);
  }];

  return current;
}

- (NSArray *)select:(ArrayBoolFnBlock)fn
{
  __block NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];

  [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if (fn(obj)) {
      [arr addObject:obj];
    }
  }];

  return [arr copy];
}

- (NSArray *)reject:(ArrayBoolFnBlock)fn
{
  return [self select:^BOOL(id element) {
    return !fn(element);
  }];
}

#pragma mark - Property based access

- (void (^)(ArrayVoidFnBlock))each
{
  return ^(ArrayVoidFnBlock fn) {
    return [self each:fn];
  };
}

- (NSArray *(^)(ArrayIdFnBlock))map
{
  return ^NSArray *(ArrayIdFnBlock fn) {
    return [self map:fn];
  };
}

- (id (^)(id, ArrayReduceFnBlock))reduce
{
  return ^id(id initial, ArrayReduceFnBlock fn) {
    return [self reduce:initial fn:fn];
  };
}

- (NSArray<id> *(^)(ArrayBoolFnBlock))select
{
  return ^NSArray *(ArrayBoolFnBlock fn) {
    return [self select:fn];
  };
}

- (NSArray<id> *(^)(ArrayBoolFnBlock))reject
{
  return ^NSArray *(ArrayBoolFnBlock fn) {
    return [self reject:fn];
  };
}

@end

NS_ASSUME_NONNULL_END