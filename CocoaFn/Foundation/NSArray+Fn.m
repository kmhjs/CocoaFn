//
//  NSArray+Fn.m
//  CocoaFn
//
//  Created by Kazuki Murakami on 7/23/16.
//  Copyright © 2016 Himajinworks. All rights reserved.
//

#import "NSArray+Fn.h"

@implementation NSArray (Fn)

- (void)each:(void (^)(id))fn
{
  [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    fn(obj);
  }];
}

- (NSArray *)map:(id (^)(id))fn
{
  __block NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];

  [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [arr addObject:fn(obj)];
  }];

  return [arr copy];
}

- (id)reduce:(id)initial fn:(id (^)(id, id))fn
{
  __block id current = initial;

  [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    current = fn(current, obj);
  }];

  return current;
}

- (NSArray *)select:(BOOL (^)(id element))fn
{
  __block NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];

  [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if (fn(obj)) {
      [arr addObject:obj];
    }
  }];

  return [arr copy];
}

- (NSArray *)reject:(BOOL (^)(id element))fn
{
  return [self select:^BOOL(id element) {
    return !fn(element);
  }];
}

@end
