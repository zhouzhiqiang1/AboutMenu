Pod::Spec.new do |s|  
  s.name         = "AboutMenu"
  s.version      = "0.9.2"
  s.summary      = "An iOS activity indicator view."
  s.description  = <<-DESC
                    This is a test.
                   DESC
  s.homepage     = "https://github.com/zhouzhiqiang1/AboutMenu"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "周志强" => "zhou83955@sina.com" }  
  s.source       = { :git => "https://github.com/zhouzhiqiang1/AboutMenu.git", :tag => s.version.to_s }
  s.platform     = :ios
  s.source_files = '*.{h,m}'
  s.framework    = "CoreGraphics"
  s.requires_arc = true
end  