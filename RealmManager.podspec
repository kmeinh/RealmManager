
Pod::Spec.new do |s|

  s.name                    = "RealmManager"
  s.version                 = "0.0.3"
  s.summary                 = "Database Manager for Realm written in Swift"
  s.homepage                = "https://github.com/konDeichmann/RealmManager"
  s.license                 = { :type => "MIT", :file => "LICENSE" }
  s.author                  = { "kondeichmann" => "k.deichmann@mac.com" }
  s.platform                = :ios
  s.ios.deployment_target   = '9.0'
  s.source                  = { :git => "https://github.com/konDeichmann/RealmManager.git", :tag => "#{s.version}" }
  s.source_files            = "RealmManager/**/*.{swift}"
  s.framework               = "Foundation"
  s.requires_arc            = true

  s.dependency 'RealmSwift', '~> 2.4.1'

end
