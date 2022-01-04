# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# arch -x86_64 pod install

post_install do |installer|   
      installer.pods_project.build_configurations.each do |config|
        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      end
end

target 'Kouzina' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'IQKeyboardManagerSwift'
  pod 'SwiftyJSON'
  pod 'Alamofire'
  pod 'NVActivityIndicatorView', '4.8.0'
  pod 'ReachabilitySwift'
  pod 'ObjectMapper'
  pod 'SDWebImage'
  pod 'GoogleMaps'
  pod 'FittedSheets'
  pod 'GoogleSignIn'
  pod 'FBSDKLoginKit'

  target 'KouzinaTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'KouzinaUITests' do
    # Pods for testing
  end

end