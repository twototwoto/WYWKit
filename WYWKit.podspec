
Pod::Spec.new do |spec|
    spec.name         = "WYWKit"
    spec.version      = "0.0.1"
    spec.summary      = "WYWKit"
    spec.description  = "WYWKit description"
    spec.homepage     = "https://github.com/twototwoto/WYWKit"
    # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
    spec.license      = { :type => "MIT", :file => "LICENSE" }
    spec.author             = { "twototwoto" => "2637405168@qq.com" }
    spec.social_media_url   = "https://github.com/twototwoto"
    spec.platform     = :ios, "9.0"
    spec.source       = { :git => "https://github.com/twototwoto/WYWKit.git", :tag => "#{spec.version}" }
    # spec.source_files  = "Classes", "WYWKit/WYWKit/Classes/**/*.{h,m}"
    spec.default_subspec = 'Core'
    spec.requires_arc = true
    
    spec.subspec 'Core' do |core|
        core.source_files = 'WYWKit/WYWKit/Core/*.{h,m}', 'WYWKit/WYWKit/WYWKit.h'
    end
    
    spec.subspec 'WYWFPSLabel' do |fps|
        fps.ios.deployment_target = '9.0'
        fps.source_files = 'WYWKit/WYWKit/WYWFPSLabel/*.{h,m}'
        fps.framework = 'WYWFPSLabel'
        fps.dependency 'WYWKit/WYWKit/Core'
    end
    
    # spec.exclude_files = "Classes/Exclude"
    # spec.public_header_files = "Classes/**/*.h"
    # spec.resource  = "icon.png"
    # spec.resources = "Resources/*.png"
    # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"
    # spec.framework  = "SomeFramework"
    # spec.frameworks = "SomeFramework", "AnotherFramework"
    # spec.library   = "iconv"
    # spec.libraries = "iconv", "xml2"
    # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
    # spec.dependency "JSONKit", "~> 1.4"
end
