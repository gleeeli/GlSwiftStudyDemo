#
# Be sure to run `pod lib lint PPBaseModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PPBaseModule'
  s.version          = '0.1.0'
  s.summary          = 'A short description of PPBaseModule.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/jacky wang/PPBaseModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jacky wang' => 'wangjianke@taqu.cn' }
  s.source           = { :git => 'https://github.com/jacky wang/PPBaseModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.requires_arc = true
  s.static_framework = true
  s.swift_version = '5.1'

  s.source_files = "#{s.name}/Classes/**/*.{h,m,swift}"
  
  s.dependency "HBPublic"

  s.dependency 'CocoaLumberjack/Swift'

  s.dependency "HandyJSON"
  s.dependency 'SwiftyJSON'
  s.dependency "RxSwift"
  s.dependency 'XHBUIKit'
  s.dependency 'XHBFrame'
  s.dependency 'XHBTool'
  s.dependency 'RxDataSources'
  s.dependency 'lottie-ios'
  s.dependency 'Then'
  s.dependency 'XHBIMClient'
  s.dependency 'SwifterSwift'
  s.dependency 'XHBTrackerKit'

#  s.dependency 'PPUIKit'

  # s.resource_bundles = {
  #   'PPBaseModule' => ['PPBaseModule/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
