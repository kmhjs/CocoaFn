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

typedef void (^SetVoidFnBlock)(ObjectType element);
typedef id _Nonnull (^SetIdFnBlock)(ObjectType element);
typedef id _Nonnull (^SetReduceFnBlock)(id accumlator, ObjectType element);
typedef BOOL (^SetBoolFnBlock)(ObjectType element);

@property (readonly) void (^each)(SetVoidFnBlock fn);
@property (readonly) NSSet *(^map)(SetIdFnBlock fn);
@property (readonly) id (^reduce)(id initial, SetReduceFnBlock fn);
@property (readonly) NSSet<ObjectType> *(^select)(SetBoolFnBlock fn);
@property (readonly) NSSet<ObjectType> *(^reject)(SetBoolFnBlock fn);

- (void)each:(SetVoidFnBlock)fn;
- (NSSet *)map:(SetIdFnBlock)fn;
- (id)reduce:(id)initial fn:(SetReduceFnBlock)fn;
- (NSSet<ObjectType> *)select:(SetBoolFnBlock)fn;
- (NSSet<ObjectType> *)reject:(SetBoolFnBlock)fn;

@end

NS_ASSUME_NONNULL_END