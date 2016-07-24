//
//  NSArray+FnTests.m
//  CocoaFn
//
//  Created by Kazuki Murakami on 7/23/16.
//  Copyright © 2016 Himajinworks. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "NSArray+Fn.h"

@interface NSArray_FnTests : XCTestCase

@property (nonatomic, copy) NSArray<NSString *> *stringTestSet;
@property (nonatomic, copy) NSArray<NSNumber *> *numberTestSet;

@end

@implementation NSArray_FnTests

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.

  self.stringTestSet = @[@"a", @"b", @"c"];
  self.numberTestSet = @[@(1), @(2), @(3), @(4), @(5)];
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

#pragma mark - Each

- (void)eachTestBase:(NSArray<NSString *> *)result
{
  /**
   *  Checks content length
   */
  expect([result count]).to.equal([self.stringTestSet count]);

  /**
   *  Checks actual contents
   */
  expect(result).to.equal(self.stringTestSet);
}

- (void)testEach
{
  __block NSMutableArray<NSString *> *result = [NSMutableArray arrayWithCapacity:0];

  [self.stringTestSet each:^(NSString *element) {
    [result addObject:element];
  }];

  [self eachTestBase:[result copy]];
}

- (void)testPropertyBasedEach
{
  __block NSMutableArray<NSString *> *result = [NSMutableArray arrayWithCapacity:0];

  self.stringTestSet.each(^(NSString *element) {
    [result addObject:element];
  });

  [self eachTestBase:result];
}

#pragma mark - Map

- (void)mapTestBase:(NSArray<NSString *> *)result
{
  /**
   *  Checks content length
   */
  expect([result count]).to.equal([self.stringTestSet count]);

  /**
   *  Checks contents
   */
  [self.stringTestSet enumerateObjectsWithOptions:NSEnumerationConcurrent
                                       usingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                         NSString *expected = [NSString stringWithFormat:@"element = %@", obj];
                                         expect(result).to.contain(expected);
                                       }];
}

- (void)testMap
{
  [self mapTestBase:[self.stringTestSet map:^id(id element) {
    return [NSString stringWithFormat:@"element = %@", (NSString *)element];
  }]];
}

- (void)testPropertyBasedMap
{
  [self mapTestBase:self.stringTestSet.map(^id(id element) {
    return [NSString stringWithFormat:@"element = %@", (NSString *)element];
  })];
}

#pragma mark - Reduce

- (void)reduceNumberTestBase:(NSNumber *)result
{
  /**
   *  Checks content
   */
  expect([result floatValue]).to.equal(15.0);
}

- (void)testReduceNumber
{
  [self reduceNumberTestBase:[self.numberTestSet reduce:@(0)
                                                     fn:^id(NSNumber *accumlator, NSNumber *element) {
                                                       return @([accumlator floatValue] + [element floatValue]);
                                                     }]];
}

- (void)testPropertyBasedReduceNumber
{
  [self reduceNumberTestBase:self.numberTestSet.reduce(@(0), ^id(NSNumber * accumlator, id element) {
    return @([accumlator floatValue] + [element floatValue]);
  })];
}


- (void)reduceStringTestBase:(NSString *)result
{
  /**
   *  Checks content
   */
  expect(result).to.equal(@"a, b, c");
}

- (void)testReduceString
{
  [self reduceStringTestBase:[self.stringTestSet reduce:@""
                                                     fn:^id(NSString *accumlator, NSString *element) {
                                                       if (accumlator.length < 1) {
                                                         return element;
                                                       }

                                                       return [NSString stringWithFormat:@"%@, %@", accumlator, element];
                                                     }]];
}

- (void)testPropertyBasedReduceString
{
  [self reduceStringTestBase:self.stringTestSet.reduce(@"", ^id(NSString *accumlator, NSString *element) {
    if (accumlator.length < 1) {
      return element;
    }

    return [NSString stringWithFormat:@"%@, %@", accumlator, element];
  })];
}

#pragma mark - Select

- (void)selectTestBase:(NSArray<NSNumber *> *)result
{
  /**
   *  Checks content length
   *  In this case, 4, 5 should be in the array
   */
  expect([result count]).to.equal(2);

  /**
   *  Checks contents
   */
  expect(result).to.equal(@[@(4), @(5)]);
}

- (void)testSelect
{
  [self selectTestBase:[self.numberTestSet select:^BOOL(NSNumber *element) {
    return [element floatValue] > 3;
  }]];
}

- (void)testPropertyBasedSelect
{
  [self selectTestBase:self.numberTestSet.select(^BOOL(NSNumber *element) {
    return [element floatValue] > 3;
  })];
}

#pragma mark - Reject

- (void)rejectTestBase:(NSArray<NSNumber *> *)result
{
  /**
   *  Checks content length
   *  In this case, 4, 5 should be in the array
   */
  expect([result count]).to.equal(2);

  /**
   *  Checks contents
   */
  expect(result).to.equal(@[@(4), @(5)]);
}

- (void)testReject
{
  [self rejectTestBase:[self.numberTestSet reject:^BOOL(NSNumber *element) {
    return [element floatValue] <= 3;
  }]];
}

- (void)testPropertyBasedReject
{
  [self rejectTestBase:self.numberTestSet.reject(^BOOL(NSNumber *element) {
    return [element floatValue] <= 3;
  })];
}

#pragma mark - Combination

- (void)mapSelectTestBase:(NSArray<NSNumber *> *)result
{
  /**
   *  Checks content length
   *  In this case, 40, 50 should be in the array
   */
  expect([result count]).to.equal(2);

  /**
   *  Checks contents
   */
  expect(result).to.equal(@[@(40), @(50)]);
}

- (void)testMapSelect
{
  [self mapSelectTestBase:[[self.numberTestSet map:^id _Nonnull(NSNumber * _Nonnull element) {
    return @([element floatValue] * 10);

  }] select:^BOOL(id  _Nonnull element) {
    return [element floatValue] > 30;

  }]];
}

- (void)testPropertyBasedMapSelect
{
  [self mapSelectTestBase:self.numberTestSet.map(^id _Nonnull(NSNumber * _Nonnull element) {
    return @([element floatValue] * 10);

  }).select(^BOOL(id  _Nonnull element) {
    return [element floatValue] > 30;

  })];
}

@end
