//
//  NSArray+Fn.h
//  CocoaFn
//
//  Created by Kazuki Murakami on 7/23/16.
//  Copyright © 2016 Himajinworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<__covariant ObjectType> (Fn)

- (void)each:(void (^)(ObjectType element))fn;
- (NSArray *)map:(id (^)(ObjectType element))fn;
- (id)reduce:(id)initial fn:(id (^)(id accumlator, ObjectType element))fn;
- (NSArray<ObjectType> *)select:(BOOL (^)(ObjectType element))fn;
- (NSArray<ObjectType> *)reject:(BOOL (^)(ObjectType element))fn;

@end
