#
# Be sure to run `pod lib lint PPUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PPUIKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of PPUIKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/linqinglin/PPUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'linqinglin' => 'linqinglin@taqu.cn' }
  s.source           = { :git => 'https://github.com/linqinglin/PPUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.static_framework = true
  
  s.source_files = "#{s.name}/Classes/**/*.{h,m,swift}"
  
  s.resource_bundles = {
    'PPUIKit' => ['PPUIKit/**/*.{png,jpg,json,svg}'],
    'PPUIKitAsset' => ['PPUIKit/Resource/*.xcassets']
  }
  
  s.resources = ['PPUIKit/**/Resource/**/*.{png,svg,plist,gif}']
  
  

  
  s.dependency 'HBPublic'
  s.dependency 'XHBTool'
  s.dependency 'XHBSwiftKit'
  
  s.dependency 'SnapKit'
  s.dependency 'Then'
  s.dependency 'RxCocoa'
  s.dependency 'lottie-ios' 
  s.dependency 'LottiePlugin'
  s.dependency 'SDWebImage'
  s.dependency 'PPBaseModule'
  
end
