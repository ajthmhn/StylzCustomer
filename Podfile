# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

#inhibit_all_warnings!

def appPods
  pod 'IQKeyboardManagerSwift'
  pod 'DropDown'
  pod 'FSCalendar'
  pod 'Kingfisher'
  pod 'AEOTPTextField'
  pod 'ImageSlideshow/Alamofire'
  pod 'IndicateKit', '~> 2.0.0'
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'MaterialComponents/TextControls+OutlinedTextFields'
  pod 'Urway',:git=>'https://github.com/URWAYios/UrwaySDK.git'
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'

end

def apiPods
pod 'SwiftyJSON'
pod 'Result'
pod 'Moya'
end

target 'StylezUser' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  appPods

  # Pods for StylezUser

end

target 'StylesWebKit' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  apiPods

  # Pods for StylezUser

end


post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.1'
        xcconfig_path = config.base_configuration_reference.real_path
        xcconfig = File.read(xcconfig_path)
        xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
        File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
      end
    end
  end
end