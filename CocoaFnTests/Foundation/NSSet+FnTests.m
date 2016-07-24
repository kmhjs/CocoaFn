//
//  NSSet+FnTests.m
//  CocoaFn
//
//  Created by Kazuki Murakami on 7/24/16.
//  Copyright © 2016 Himajinworks. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "NSSet+Fn.h"

@interface NSSet_FnTests : XCTestCase

@property (nonatomic, copy) NSSet<NSString *> *stringTestSet;
@property (nonatomic, copy) NSSet<NSNumber *> *numberTestSet;

@end

@implementation NSSet_FnTests

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.

  self.stringTestSet = [NSSet setWithObjects:@"a", @"b", @"c", nil];
  self.numberTestSet = [NSSet setWithObjects:@(1), @(2), @(3), @(4), @(5), nil];
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

#pragma mark - Each

- (void)eachTestBase:(NSSet<NSString *> *)result
{
  /**
   *  Checks content length
   */
  expect([result count]).to.equal([self.stringTestSet count]);

  /**
   *  Checks actual contents
   */
  expect(result).to.beSupersetOf(self.stringTestSet);
  expect(self.stringTestSet).to.beSupersetOf(result);
}

- (void)testEach
{
  __block NSMutableSet<NSString *> *result = [NSMutableSet setWithCapacity:0];

  [self.stringTestSet each:^(NSString * _Nonnull element) {
    [result addObject:element];
  }];

  [self eachTestBase:result];
}

- (void)testPropertyBasedEach
{
  __block NSMutableSet<NSString *> *result = [NSMutableSet setWithCapacity:0];

  self.stringTestSet.each(^(NSString * _Nonnull element) {
    [result addObject:element];
  });

  [self eachTestBase:result];
}

#pragma mark - Map

- (void)mapTestBase:(NSSet<NSString *> *)result
{
  /**
   *  Checks content length
   */
  expect([result count]).to.equal([self.stringTestSet count]);

  /**
   *  Checks contents
   */
  [self.stringTestSet enumerateObjectsWithOptions:NSEnumerationConcurrent
                                       usingBlock:^(NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
                                         NSString *expected = [NSString stringWithFormat:@"element = %@", obj];
                                         expect(result).to.contain(expected);
                                       }];
}

- (void)testMap
{
  [self mapTestBase:[self.stringTestSet map:^NSString * _Nonnull(NSString *  _Nonnull element) {
    return [NSString stringWithFormat:@"element = %@", (NSString *)element];
  }]];
}

- (void)testPropertyBasedMap
{
  [self mapTestBase:self.stringTestSet.map(^NSString * _Nonnull(NSString *  _Nonnull element) {
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
  [self reduceNumberTestBase:self.numberTestSet.reduce(@(0), ^id(NSNumber *accumlator, NSNumber *element) {
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

- (void)selectTestBase:(NSSet<NSNumber *> *)result
{
  /**
   *  Checks content length
   *  In this case, 4, 5 should be in the array
   */
  expect([result count]).to.equal(2);

  /**
   *  Checks contents
   */
  NSSet<NSNumber *> *expected = [NSSet setWithObjects:@(4), @(5), nil];
  expect(result).to.beSupersetOf(expected);
  expect(expected).to.beSupersetOf(result);
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

- (void)rejectTestBase:(NSSet<NSNumber *> *)result
{
  /**
   *  Checks content length
   *  In this case, 4, 5 should be in the array
   */
  expect([result count]).to.equal(2);

  /**
   *  Checks contents
   */
  NSSet<NSNumber *> *expected = [NSSet setWithObjects:@(4), @(5), nil];
  expect(result).to.beSupersetOf(expected);
  expect(expected).to.beSupersetOf(result);
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

@end
