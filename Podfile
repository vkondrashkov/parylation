workspace 'Parylation.xcworkspace' 
use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end

platform :ios, '11.0'

project 'Parylation/Parylation'
project 'ParylationDomain/ParylationDomain'  

def common_pods
  pod 'RxSwift', '~> 5.1'
  pod 'RxCocoa', '~> 5.1'
  pod 'RealmSwift', '~> 5.0'
  pod 'lottie-ios', '~> 3.2'
end

def app_pods
  pod 'SnapKit', '~> 5.0.0'
  pod 'Moya/RxSwift', '~> 14.0'
  pod 'RxDataSources', '~> 4.0'
  pod 'SwiftGen', '~> 6.0' 
end

def test_pods
  pod 'Quick', '~> 2.0'
  pod 'Nimble', '~> 8.0'
  pod 'RxBlocking', '~> 5.1'
  pod 'RxTest', '~> 5.1'
end

target 'Parylation' do
  project 'Parylation/Parylation'
  app_pods
  common_pods
end

target 'ParylationDev' do
  project 'Parylation/Parylation'
  app_pods
  common_pods
end

target 'ParylationDevTests' do
  project 'Parylation/Parylation'
  test_pods
  common_pods
end  

target 'ParylationDomain' do
  project 'ParylationDomain/ParylationDomain'
  common_pods
end
