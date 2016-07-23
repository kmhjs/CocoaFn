//
//  NSDictionary+Fn.h
//  CocoaFn
//
//  Created by Kazuki Murakami on 7/23/16.
//  Copyright © 2016 Himajinworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (Fn)

- (void)each:(void (^)(KeyType key, ObjectType value))fn;
- (NSDictionary *)map:(id (^)(KeyType key, ObjectType value))fn;
- (id)reduce:(id)initial fn:(id (^)(id accumlator, KeyType key, ObjectType value))fn;
- (NSDictionary<KeyType, ObjectType> *)select:(BOOL (^)(KeyType key, ObjectType value))fn;
- (NSDictionary<KeyType, ObjectType> *)reject:(BOOL (^)(KeyType key, ObjectType value))fn;

@end
