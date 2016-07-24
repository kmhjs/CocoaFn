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

- (void)testEach
{
  __block NSMutableSet<NSString *> *result = [NSMutableSet setWithCapacity:0];

  [self.stringTestSet each:^(NSString * _Nonnull element) {
    [result addObject:element];
  }];

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

- (void)testMap
{
  __block NSSet<NSString *> *result = [self.stringTestSet map:^NSString * _Nonnull(NSString *  _Nonnull element) {
    return [NSString stringWithFormat:@"element = %@", (NSString *)element];
  }];

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

- (void)testReduceNumber
{
  NSNumber *result = [self.numberTestSet reduce:@(0)
                                             fn:^id(NSNumber *accumlator, NSNumber *element) {
                                               return @([accumlator floatValue] + [element floatValue]);
                                             }];

  /**
   *  Checks content
   */
  expect([result floatValue]).to.equal(15.0);
}

- (void)testReduceString
{
  NSString *result = [self.stringTestSet reduce:@""
                                             fn:^id(NSString *accumlator, NSString *element) {
                                               if (accumlator.length < 1) {
                                                 return element;
                                               }

                                               return [NSString stringWithFormat:@"%@, %@", accumlator, element];
                                             }];

  /**
   *  Checks content
   */
  expect(result).to.equal(@"a, b, c");
}

- (void)testSelect
{
  NSSet<NSNumber *> *result = [self.numberTestSet select:^BOOL(NSNumber *element) {
    return [element floatValue] > 3;
  }];

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
  NSSet<NSNumber *> *result = [self.numberTestSet reject:^BOOL(NSNumber *element) {
    return [element floatValue] <= 3;
  }];

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

@end
