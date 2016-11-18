Pod::Spec.new do |s|
    s.name                      = "Metatron"
    s.version                   = "1.1.0"
    s.summary                   = "Swift framework that edits meta-information of audio files"
    s.homepage                  = "https://github.com/almazrafi/Metatron"
    s.license                   = { :type => "MIT", :file => "LICENSE" }
    s.author                    = { "Almaz Ibragimov" => "almazrafi@gmail.com" }
    s.ios.deployment_target     = "8.0"
    s.osx.deployment_target     = "10.10"
    s.watchos.deployment_target = '2.0'
    s.tvos.deployment_target    = '9.0'
    s.library                   = "z"
    s.source                    = { :git => "https://github.com/almazrafi/Metatron.git", :tag => s.version }
    s.source_files              = "Sources/**/*.swift"
end
