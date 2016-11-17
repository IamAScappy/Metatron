Pod::Spec.new do |s|
    s.name                      = "Metatron"
    s.version                   = "1.0.0"
    s.summary                   = "Swift framework that edits meta-information of audio files"
    s.homepage                  = "https://github.com/almazrafi/Metatron"
    s.license                   = { :type => "Apache 2.0", :file => "LICENSE" }
    s.author                    = { "Almaz Ibragimov" => "username@mail.domain" }
    s.ios.deployment_target     = "8.0"
    s.osx.deployment_target     = "10.10"
    s.watchos.deployment_target = '2.0'
    s.tvos.deployment_target    = '9.0'
    s.library                   = "z"
    s.source                    = { :git => "https://github.com/almazrafi/Metatron.git", :tag => s.version.to_s }
    s.source_files              = "Sources/**/*.swift"
end
