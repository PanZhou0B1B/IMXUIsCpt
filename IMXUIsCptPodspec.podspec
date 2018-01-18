#
#  Be sure to run `pod spec lint IMXUIsCptPodspec.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "IMXUIsCpt"
  s.version      = "1.0.0"
  s.summary      = "IMXUIsCpt:UIs componet sets."

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "zhoupanpan" => "2331838272@qq.com" }
  
  s.platform     = :ios, "8.0"
  #s.ios.deployment_target = '8.0' #  When using multiple platforms

  s.homepage     = "https://github.com/PanZhow/IMXUIsCpt.git"
  s.source       = { :git => "https://github.com/PanZhow/IMXUIsCpt.git", :tag => "#{s.version}" }

  s.requires_arc = true


# IMXUIKitExt Cpt
  s.subspec 'IMXUIKitExt' do |uext|
    uext.source_files  = 'IMXUIsCpt/Libs/2nd/IMXUIKitExt/*.{h,m}'
    uext.public_header_files = [
      'IMXUIsCpt/Libs/2nd/IMXUIKitExt/*.{h}'
    ]
  end

# IMXTips Cpt
  s.subspec 'IMXTips' do |tips|
    tips.source_files  = 'IMXUIsCpt/Libs/2nd/IMXTips/*.{h,m}'
    tips.public_header_files = [
      'IMXUIsCpt/Libs/2nd/IMXTips/*.{h}'
    ]
    tips.dependency 'MBProgressHUD' ,'1.0.0'
    tips.dependency 'IMXUIsCpt/Libs/2nd/IMXUIKitExt'
    tips.dependency 'IMXUIsCpt/Libs/2nd/IMXStyleKit'
  end

# IMXDeviceInfo Cpt
  s.subspec 'IMXDeviceInfo' do |dinfo|
    dinfo.source_files  = 'IMXUIsCpt/Libs/2nd/IMXDeviceInfo/*.{h,m}'
    dinfo.public_header_files = [
      'IMXUIsCpt/Libs/2nd/IMXDeviceInfo/*.{h}'
    ]
  end

# IMXTabBarKit Cpt
  s.subspec 'IMXTabBarKit' do |tabkit|
    tabkit.source_files  = 'IMXUIsCpt/Cpts/IMXTabBarKit/*.{h,m}'
    tabkit.public_header_files = [
      'IMXUIsCpt/Cpts/IMXTabBarKit/*.{h}'
    ]
    tabkit.dependency 'Masonry' ,'1.1.0'
  end
end
