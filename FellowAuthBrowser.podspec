require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name = 'FellowAuthBrowser'
  s.version = package['version']
  s.summary = package['description']
  s.license = package['license']
  s.author = package['author']
  s.homepage = "https://github.com/fellow/authbrowser"
  s.source = { :git => 'https://github.com/fellow/authbrowser.git', :tag => package['name'] + '@' + package['version'] }
  s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}', 'browser/ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
  s.ios.deployment_target  = '13.0'
  s.dependency 'Capacitor'
  s.swift_version = '5.1'
end