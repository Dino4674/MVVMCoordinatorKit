#
# Be sure to run `pod lib lint MVVMCoordinatorKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MVVMCoordinatorKit'
  s.version          = '0.1.2'
  s.summary          = 'Kit that helps you with UIViewController creation, navigation, and organization into reusable flows using the MVVM+Coordinator pattern.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This Kit aims to speed up your development and help you organize Screens into coherent flows that are easily reusable using the Coordinator pattern, making navigation between screens simple and readable.

This Kit also helps you create UIViewController (the View in the MVVM pattern) and its ViewModel.

Model is not part of this Kit, as it is up to the developers to define their models in the app.
                       DESC

  s.homepage         = 'https://github.com/Dino4674/MVVMCoordinatorKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dino Bartošak' => 'dino.bartosak@gmail.com' }
  s.source           = { :git => 'https://github.com/Dino4674/MVVMCoordinatorKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'

  s.source_files = 'MVVMCoordinatorKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MVVMCoordinatorKit' => ['MVVMCoordinatorKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
