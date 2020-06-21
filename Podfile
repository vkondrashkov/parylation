workspace 'Parylation.xcworkspace' 
use_frameworks!

platform :ios, '11.0'

project 'Parylation/Parylation'
project 'ParylationDomain/ParylationDomain'  

def common_pods
  pod 'ReactiveKit', '~> 3.0'
  pod 'Bond', '~> 7.0'
end

def app_pods
  pod 'SnapKit', '~> 5.0.0'
  pod 'Moya', '~> 14.0'
  pod 'ObjectMapper', '~> 4.2'
end

def test_pods
  pod 'Quick', '~> 2.0'
  pod 'Nimble', '~> 8.0'
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
