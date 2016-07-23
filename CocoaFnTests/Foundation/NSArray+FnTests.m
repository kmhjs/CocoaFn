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

@end

@implementation NSArray_FnTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEach 
{
  NSArray<NSString *> *arr = @[@"a", @"b", @"c"];
  __block NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];

  [arr each:^(NSString *element) {
    [result addObject:element];
  }];

  /**
   *  Checks content length
   */
  expect([result count]).to.equal([arr count]);

  /**
   *  Checks actual contents
   */
  expect(result).to.equal(arr);
}

- (void)testMap
{
  NSArray<NSString *> *arr = @[@"a", @"b", @"c"];

  NSArray<NSString *> *result = [arr map:^id(id element) {
    return [NSString stringWithFormat:@"element = %@", (NSString *)element];
  }];

  /**
   *  Checks content length
   */
  expect([result count]).to.equal([arr count]);

  /**
   *  Checks contents
   */
  for (NSString *str in arr) {
    NSString *expected = [NSString stringWithFormat:@"element = %@", str];
    expect(result).to.contain(expected);
  }
}

- (void)testReduceNumber
{
  NSArray<NSNumber *> *arr = @[@(1), @(2.0), @(3)];

  NSNumber *result = [arr reduce:@(0)
                              fn:^id(NSNumber *accumlator, NSNumber *element) {
                                return @([accumlator floatValue] + [element floatValue]);
                              }];

  /**
   *  Checks content
   */
  expect([result floatValue]).to.equal(6.0);
}

- (void)testReduceString
{
  NSArray<NSString *> *arr = @[@"a", @"b", @"c"];

  NSString *result = [arr reduce:@""
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
  NSArray<NSNumber *> *arr = @[@(1), @(2), @(3), @(4), @(5)];

  NSArray<NSNumber *> *result = [arr select:^BOOL(NSNumber *element) {
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
  for (NSNumber *num in @[@(4), @(5)]) {
    expect(result).to.contain(num);
  }
}

- (void)testReject
{
  NSArray<NSNumber *> *arr = @[@(1), @(2), @(3), @(4), @(5)];

  NSArray<NSNumber *> *result = [arr reject:^BOOL(NSNumber *element) {
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
  for (NSNumber *num in @[@(4), @(5)]) {
    expect(result).to.contain(num);
  }
}

@end
