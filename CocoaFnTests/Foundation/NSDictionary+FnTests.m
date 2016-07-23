//
//  NSDictionary+FnTests.m
//  CocoaFn
//
//  Created by Kazuki Murakami on 7/24/16.
//  Copyright © 2016 Himajinworks. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "NSDictionary+Fn.h"

@implementation NSDictionary (TestUtil)

- (BOOL)hasKey:(NSString *)key
{
  return [self.allKeys containsObject:key];
}

@end

@interface NSDictionary_FnTests : XCTestCase

@end

@implementation NSDictionary_FnTests

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
  NSDictionary<NSString *, NSNumber *> *dict = @{ @"a" : @(1), @"b" : @(2), @"c" : @(3) };
  __block NSMutableDictionary<NSString *, NSNumber *> *result = [NSMutableDictionary dictionaryWithCapacity:0];

  [dict each:^(NSString *key, NSNumber *value) {
    [result setObject:value forKey:key];
  }];

  /**
   *  Checks content length
   */
  expect([result count]).to.equal([dict count]);

  /**
   *  Checks actual contents
   */
  expect(result).to.equal(dict);
}

- (void)testMap
{
  NSDictionary<NSString *, NSNumber *> *dict = @{ @"a" : @(1), @"b" : @(2), @"c" : @(3) };

  NSDictionary<NSString *, NSString *> *result = [dict map:^NSString *(NSString *key, NSNumber *value) {
    return [NSString stringWithFormat:@"%@ = %@", key, value];
  }];

  /**
   *  Checks content length
   */
  expect([result count]).to.equal([dict count]);

  /**
   *  Checks contents
   */
  [dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
    // Contains key
    expect([result hasKey:key]).to.beTruthy;

    // Contains expected element
    expect(result[key]).to.equal([NSString stringWithFormat:@"%@ = %@", key, obj]);
  }];
}

- (void)testReduceNumber
{
  NSDictionary<NSString *, NSNumber *> *dict = @{ @"a" : @(1), @"b" : @(2), @"c" : @(3) };

  NSNumber *result = [dict reduce:@(0)
                               fn:^NSNumber *(NSNumber *accumlator, NSString *key, NSNumber *value) {
                                 return @([accumlator floatValue] + [value floatValue]);
                               }];

  /**
   *  Checks content
   */
  expect([result floatValue]).to.equal(6.0);
}

- (void)testReduceString
{
  NSDictionary<NSString *, NSString *> *dict = @{ @"1" : @"a", @"2" : @"b", @"3" : @"c" };

  NSString *result = [dict reduce:@""
                               fn:^NSString *(NSString *accumlator, NSString *key, NSString *value) {
                                 if (accumlator.length < 1) {
                                   return value;
                                 }

                                 return [NSString stringWithFormat:@"%@, %@", accumlator, value];
                               }];
  /**
   *  Checks content
   */
  expect(result).to.equal(@"a, b, c");
}

- (void)testSelect
{
  NSDictionary<NSString *, NSString *> *dict = @{ @"1" : @"a", @"2" : @"b", @"3" : @"c" };

  NSDictionary<NSString *, NSString *> *result = [dict select:^BOOL(NSString *key, NSString *value) {
    return [key isEqualToString:@"2"];
  }];

  /**
   *  Checks content length
   *  In this case, @{ @"2" : @"b" } should be in the dictionary
   */
  expect([result count]).to.equal(1);

  /**
   *  Checks contents
   */
  expect([result hasKey:@"2"]).to.beTruthy;
  expect(result[@"2"]).to.equal(@"b");
}

- (void)testReject
{
  NSDictionary<NSString *, NSString *> *dict = @{ @"1" : @"a", @"2" : @"b", @"3" : @"c" };

  NSDictionary<NSString *, NSString *> *result = [dict reject:^BOOL(NSString *key, NSString *value) {
    return ![key isEqualToString:@"2"];
  }];

  /**
   *  Checks content length
   *  In this case, @{ @"2" : @"b" } should be in the dictionary
   */
  expect([result count]).to.equal(1);

  /**
   *  Checks contents
   */
  expect([result hasKey:@"2"]).to.beTruthy;
  expect(result[@"2"]).to.equal(@"b");
}

@end
