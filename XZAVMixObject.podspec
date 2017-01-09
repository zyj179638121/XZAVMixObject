Pod::Spec.new do |s|

  s.name         = "XZAVMixObject"
  s.version      = "1.0"
  s.summary      = "XZAVMixObject."

  s.description  = <<-DESC
                    this is XZAVMixObject
                   DESC

  s.homepage     = "https://github.com/zyj179638121/XZAVMixObject"

  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author       = { "zyj179638121" => "179638121@qq.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/zyj179638121/XZAVMixObject.git", :tag => s.version.to_s }

  s.source_files  = "XZAVMixObject/XZAVMixObject/**/*.{h,m}"

  s.requires_arc = true


end
