Pod::Spec.new do |s|
  s.name = "MAFOAuth2ClientSignInViewController"
  s.version = "0.1.0"
  s.summary = "MAFOAuth2ClientSignInViewController implements the login user interface of AFOAuth2Client."
  s.homepage = "https://github.com/miyagi389/MAFOAuth2ClientSignInViewController"
  s.screenshots = "https://raw.githubusercontent.com/miyagi389/MAFOAuth2ClientSignInViewController/master/Images/screenshot_001.png"
  s.license = 'MIT'
  s.author = { "miyagi389" => "miyagi389@gmail.com" }
  s.source = { :git => "http://EXAMPLE/NAME.git", :tag => s.version.to_s }

  s.platform = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/ios/*.{h,m}'

#  s.dependency 'AFOAuth2Client', :git => 'https://github.com/mlwelles/AFOAuth2Client.git'
end
