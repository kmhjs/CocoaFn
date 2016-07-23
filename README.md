# CocoaFn

Collection extensions for Objective-C. (ARC environment)

## Current progress

* [x] `NSArray`
* [x] `NSDictionary`

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

## License

See `LICENSE` .
