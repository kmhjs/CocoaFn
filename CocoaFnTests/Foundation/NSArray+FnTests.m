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

- (void)testEach 
{
  __block NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];

  [self.stringTestSet each:^(NSString *element) {
    [result addObject:element];
  }];

  /**
   *  Checks content length
   */
  expect([result count]).to.equal([self.stringTestSet count]);

  /**
   *  Checks actual contents
   */
  expect(result).to.equal(self.stringTestSet);
}

- (void)testMap
{
  NSArray<NSString *> *result = [self.stringTestSet map:^id(id element) {
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
                                       usingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
  NSArray<NSNumber *> *result = [self.numberTestSet select:^BOOL(NSNumber *element) {
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
  expect(result).to.equal(@[@(4), @(5)]);
}

- (void)testReject
{
  NSArray<NSNumber *> *result = [self.numberTestSet reject:^BOOL(NSNumber *element) {
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
  expect(result).to.equal(@[@(4), @(5)]);
}

@end
