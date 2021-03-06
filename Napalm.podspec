#
# Be sure to run `pod lib lint Napalm.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'Napalm'
s.version          = '0.5.5'
s.summary          = 'A CocoaPod to boost your workflow and put code at an even higher level.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
Napalm takes everyday tasks in you iOS development and makes your work faster by putting it into easy to use functions.
DESC

s.homepage         = 'https://github.com/Napalm-Framework/Napalm'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Caleb' => 'caleb.kleveter@gmail.com' }
s.source           = { :git => 'https://github.com/Napalm-Framework/Napalm.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

s.source_files = 'Napalm/Classes/**/*'

# s.resource_bundles = {
#   'Napalm' => ['Napalm/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
s.frameworks = 'UIKit', 'Foundation', 'AudioToolbox', 'AVFoundation', 'GameplayKit', 'CoreLocation'
# s.dependency 'BluetoothKit', '~> 0.3.0'
end
