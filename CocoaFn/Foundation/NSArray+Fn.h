//
//  NSArray+Fn.h
//  CocoaFn
//
//  Created by Kazuki Murakami on 7/23/16.
//  Copyright © 2016 Himajinworks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<__covariant ObjectType> (Fn)

typedef void (^ArrayVoidFnBlock)(ObjectType element);
typedef id _Nonnull (^ArrayIdFnBlock)(ObjectType element);
typedef id _Nonnull (^ArrayReduceFnBlock)(id accumlator, ObjectType element);
typedef BOOL (^ArrayBoolFnBlock)(ObjectType element);

@property (readonly) void (^each)(ArrayVoidFnBlock fn);
@property (readonly) NSArray *(^map)(ArrayIdFnBlock fn);
@property (readonly) id (^reduce)(id initial, ArrayReduceFnBlock fn);
@property (readonly) NSArray<ObjectType> *(^select)(ArrayBoolFnBlock fn);
@property (readonly) NSArray<ObjectType> *(^reject)(ArrayBoolFnBlock fn);

- (void)each:(ArrayVoidFnBlock)fn;
- (NSArray *)map:(ArrayIdFnBlock)fn;
- (id)reduce:(id)initial fn:(ArrayReduceFnBlock)fn;
- (NSArray<ObjectType> *)select:(ArrayBoolFnBlock)fn;
- (NSArray<ObjectType> *)reject:(ArrayBoolFnBlock)fn;

@end

NS_ASSUME_NONNULL_END