# Uncomment this line to define a global platform for your project
platform :ios, ’10.0’
# Uncomment this line if you're using Swift
use_frameworks!


target ‘LexusApp’ do
    pod 'Eureka'
    pod "Spruce"
    pod 'Spring', :git => 'https://github.com/MengTo/Spring.git', :branch => 'swift3'
    pod 'YNExpandableCell'
    pod 'IncrementableLabel'
    pod 'SquareMosaicLayout'
    pod 'DLRadioButton'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
