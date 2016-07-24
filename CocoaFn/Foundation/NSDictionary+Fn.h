//
//  NSDictionary+Fn.h
//  CocoaFn
//
//  Created by Kazuki Murakami on 7/23/16.
//  Copyright © 2016 Himajinworks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (Fn)

typedef void (^DictionaryVoidFnBlock)(KeyType key, ObjectType value);
typedef id _Nonnull (^DictionaryIdFnBlock)(KeyType key, ObjectType value);
typedef id _Nonnull (^DictionaryReduceFnBlock)(id accumlator, KeyType key, ObjectType value);
typedef BOOL (^DictionaryBoolFnBlock)(KeyType key, ObjectType value);

@property (readonly) void (^each)(DictionaryVoidFnBlock fn);
@property (readonly) NSDictionary *(^map)(DictionaryIdFnBlock fn);
@property (readonly) id (^reduce)(id accumlator, DictionaryReduceFnBlock fn);
@property (readonly) NSDictionary<KeyType, ObjectType> *(^select)(DictionaryBoolFnBlock fn);
@property (readonly) NSDictionary<KeyType, ObjectType> *(^reject)(DictionaryBoolFnBlock fn);

- (void)each:(DictionaryVoidFnBlock)fn;
- (NSDictionary *)map:(DictionaryIdFnBlock)fn;
- (id)reduce:(id)initial fn:(DictionaryReduceFnBlock)fn;
- (NSDictionary<KeyType, ObjectType> *)select:(DictionaryBoolFnBlock)fn;
- (NSDictionary<KeyType, ObjectType> *)reject:(DictionaryBoolFnBlock)fn;

@end

NS_ASSUME_NONNULL_END