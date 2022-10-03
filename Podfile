# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'PayWingsOAuthSDK-SampleApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PayWingsOAuthSDK-SampleApp

  pod 'PayWingsOAuthSDK', '1.0.0'
  pod 'InAppSettingsKit', '3.3.6'


  post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
	    config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        end
    end
  end

end
