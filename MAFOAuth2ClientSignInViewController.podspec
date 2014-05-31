Pod::Spec.new do |s|
  s.name = "MAFOAuth2ClientSignInViewController"
  s.version = "0.1.0"
  s.summary = "A short description of MAFOAuth2ClientSignInViewController."
  s.description = <<-DESC
    An optional longer description of MAFOAuth2ClientSignInViewController

    * Markdown format.
    * Don't worry about the indent, we strip it!
                  DESC
  s.homepage = "http://EXAMPLE/NAME"
  s.screenshots = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license = 'MIT'
  s.author = { "miyagi389" => "miyagi389@gmail.com" }
  s.source = { :git => "http://EXAMPLE/NAME.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/EXAMPLE'

  s.platform = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/ios/*.{h,m}'

#  s.dependency 'AFOAuth2Client', :git => 'https://github.com/mlwelles/AFOAuth2Client.git'
end
