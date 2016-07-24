//
//  NSSet+Fn.h
//  CocoaFn
//
//  Created by Kazuki Murakami on 7/24/16.
//  Copyright © 2016 Himajinworks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSSet<__covariant ObjectType> (Fn)

- (void)each:(void (^)(ObjectType element))fn;
- (NSSet *)map:(id (^)(ObjectType element))fn;
- (id)reduce:(id)initial fn:(id (^)(id accumlator, ObjectType element))fn;
- (NSSet<ObjectType> *)select:(BOOL (^)(ObjectType element))fn;
- (NSSet<ObjectType> *)reject:(BOOL (^)(ObjectType element))fn;

@end

NS_ASSUME_NONNULL_END