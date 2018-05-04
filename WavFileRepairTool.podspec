#
# Be sure to run `pod lib lint WavFileRepairTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WavFileRepairTool'
  s.version          = '0.1.0'
  s.summary          = 'iOS录音时，如果异常终止，比如程序crash时，音频文件使用系统API播放不了，只有一些容错性好的第三方的播放器可以播放。本工具用于修复在这种情况下的异常文件。'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/JJSon/WavFileRepairTool'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JJSon' => '515867115@qq.com' }
  s.source           = { :git => 'https://github.com/JJSon/WavFileRepairTool.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'WavFileRepairTool/Classes/**/*'
  

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Security'
  # s.dependency 'AFNetworking', '~> 2.3'
end
