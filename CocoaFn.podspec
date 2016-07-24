Pod::Spec.new do |s|
  s.name          = "CocoaFn"
  s.version       = "0.0.1"
  s.summary       = "Collection extensions for Objective-C. (ARC environment)"
  s.license       = "MIT"
  s.author        = { "K. Murakami" => "kmhjs@users.noreply.github.com" }
  s.homepage      = "https://github.com/kmhjs/CocoaFn"
  s.source        = { :git => "https://github.com/kmhjs/CocoaFn.git", :tag => "#{s.version}" }

  s.source_files        = "CocoaFn/Foundation/**/*.{h,m}"
  s.public_header_files = "CocoaFn/Foundation/**/*.h"

  s.requires_arc = true
end
