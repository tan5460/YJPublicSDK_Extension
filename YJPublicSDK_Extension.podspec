#
# Be sure to run `pod lib lint YJPublicSDK_Extension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YJPublicSDK_Extension'
  s.version          = '0.1.0'
  s.summary          = 'Swift项目基础类扩展'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Swift项目基础类扩展，方便快速构建新项目
                       DESC

  s.homepage         = 'https://github.com/tan5460/YJPublicSDK_Extension'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'YJ-T' => '313037101@qq.com' }
  s.source           = { :git => 'https://github.com/tan5460/YJPublicSDK_Extension.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'
  s.swift_version = "5.0"
  s.source_files = 'YJPublicSDK_Extension/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YJPublicSDK_Extension' => ['YJPublicSDK_Extension/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
