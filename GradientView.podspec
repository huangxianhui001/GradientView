Pod::Spec.new do |s|
  s.name         = "GradientView"
  s.version      = "0.0.1"
  s.summary      = "Easy to use view of a gradient layer."
  s.description  = "Easy to use view of a gradient layer addtion with cocoapod support."
  s.homepage     = "https://github.com/huangxianhui001/GradientView"
  s.social_media_url   = "http://www.weibo.com/u/2648268723"
  s.license= { :type => "MIT", :file => "LICENSE" }
  s.author       = { "alan" => "756673457@qq.com" }
  s.source       = { :git => "https://github.com/huangxianhui001/GradientView.git", :tag => s.version }
  s.source_files = "GradientView/*.{h,m}"
  s.ios.deployment_target = '6.0'
  s.frameworks   = 'UIKit'
  s.requires_arc = true

end