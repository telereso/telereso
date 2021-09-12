#
# Be sure to run `pod lib lint Telereso.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Telereso'
  s.version          = '0.0.1'
  s.summary          = 'Control your app resources remotely.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Control your app resources remotely using firebase remote config,.
currently support string localization, in upcoming versions will support images as well
                       DESC

  s.homepage         = 'https://www.telereso.io/'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ahna92' => 'ahmed.alnaami92@gmail.com' }
  s.source           = { :git => 'https://github.com/telereso/Telereso.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_versions = '5.0'

  s.source_files = 'Telereso/Classes/**/*'

  # s.resource_bundles = {
  #   'Telereso' => ['Telereso/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Firebase/Core', '~> 8.7.0'
  s.dependency 'Firebase/RemoteConfig', '~> 8.7.0'
  s.dependency 'SwiftyJSON', '~> 4.0'

end
