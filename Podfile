# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'weatherGift' do
  pod 'GooglePlaces'
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
