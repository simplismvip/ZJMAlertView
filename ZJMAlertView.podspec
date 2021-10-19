#
# Be sure to run `pod lib lint ZJMAlertView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZJMAlertView'
  s.version          = '0.1.1'
  s.summary          = 'A short description of ZJMAlertView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/simplismvip/ZJMAlertView.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'simplismvip' => 'tonyzhao60@gmail.com' }
  s.source           = { :git => 'https://github.com/simplismvip/ZJMAlertView.git', :tag => s.version.to_s }
  s.social_media_url = 'http://www.restcy.com'
  
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.platform      = :ios, '10.0'
  s.source_files = [ 'ZJMAlertView/*.{h,swift}' ]
  s.resources = [ 'ZJMAlertView/*.bundle' ]
 
  s.frameworks = 'UIKit'
  s.dependency 'SnapKit'
  s.dependency 'ZJMKit'
end
