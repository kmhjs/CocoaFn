# CocoaFn

Collection extensions for Objective-C. (ARC environment)

## Current progress

* [x] `NSArray`
* [x] `NSDictionary`
* [x] `NSSet`

## Common tasks

This extension provides following tasks for supported collection classes.

* `each`
* `map`
* `reduce`
* `select`
* `reject`

## Requirements

* Ruby
  * For 'CocoaPods'
* Bundler
  * RubyGems

## Dependencies

* Test
  * Expecta (~> 1.0)

## How to try

### Use in project with Cocoapods

Add following one line to your `Podfile` .

```ruby
pod 'CocoaFn', :git => 'https://github.com/kmhjs/CocoaFn.git', :branch => 'develop'
```

### Run project for test / development

1. `bundle install --path=./bundle/install`
2. `bundle exec pod install`

After these steps, you can try with `CocoaFn.xcworkspace` .

### Example

#### Each

```obj-c
[self.stringTestSet each:^(NSString *element) {
  [result addObject:element];
}];
```

```obj-c
self.stringTestSet.each(^(NSString *element) {
  [result addObject:element];
});
```

#### Map

```obj-c
[self.stringTestSet map:^id(id element) {
  return [NSString stringWithFormat:@"element = %@", (NSString *)element];
}];
```

```obj-c
self.stringTestSet.map(^id(id element) {
  return [NSString stringWithFormat:@"element = %@", (NSString *)element];
});
```

#### Reduce

```obj-c
[self.numberTestSet reduce:@(0) fn:^id(NSNumber *accumlator, NSNumber *element) {
  return @([accumlator floatValue] + [element floatValue]);
}];
```

```obj-c
self.numberTestSet.reduce(@(0), ^id(NSNumber * accumlator, id element) {
  return @([accumlator floatValue] + [element floatValue]);
});
```

#### Select

```obj-c
[self.numberTestSet select:^BOOL(NSNumber *element) {
  return [element floatValue] > 3;
}];
```

```obj-c
self.numberTestSet.select(^BOOL(NSNumber *element) {
  return [element floatValue] > 3;
});
```

#### Reject

```obj-c
[self.numberTestSet reject:^BOOL(NSNumber *element) {
  return [element floatValue] <= 3;
}];
```

```obj-c
self.numberTestSet.reject(^BOOL(NSNumber *element) {
  return [element floatValue] <= 3;
});
```

#### Combination

```obj-c
[[self.numberTestSet map:^id _Nonnull(NSNumber * _Nonnull element) {
  return @([element floatValue] * 10);

}] select:^BOOL(id  _Nonnull element) {
  return [element floatValue] > 30;

}];
```

```obj-c
self.numberTestSet.map(^id _Nonnull(NSNumber * _Nonnull element) {
  return @([element floatValue] * 10);

}).select(^BOOL(id  _Nonnull element) {
  return [element floatValue] > 30;

});
```

## License

See `LICENSE` .
