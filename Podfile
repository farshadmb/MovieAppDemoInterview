# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'MovieDemoApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MovieDemoApp
  pod 'PureLayout'
  pod 'Alamofire' 
  pod 'RxDataSources'
  pod 'RxSwift'
  pod 'RxSwiftExt'
  pod 'RxCocoa'
  pod 'SDWebImage'
  # framework embedded in IPA file.

  # Utilities
  pod 'SwiftLint' # for better syntax

  target 'MovieDemoAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MovieDemoAppUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  # this code for make resolve waring that be noticed by xcode 13.
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end
