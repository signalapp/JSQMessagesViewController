Pod::Spec.new do |s|
	s.name = 'JSQMessagesViewController'
	s.version = '7.3.4'
	s.summary = 'An elegant messages UI library for iOS.'
	s.homepage = 'http://jessesquires.github.io/JSQMessagesViewController'
	s.license = 'MIT'
	s.platform = :ios, '7.0'

	s.author = 'Jesse Squires'
	s.social_media_url = 'https://twitter.com/jesse_squires'

	s.source = { :git => 'https://github.com/jessesquires/JSQMessagesViewController.git', :tag => s.version }
	s.source_files = 'JSQMessagesViewController/**/*.{h,m}'

	s.resources = ['JSQMessagesViewController/Assets/JSQMessagesAssets.bundle']

	s.frameworks = 'QuartzCore', 'CoreGraphics', 'CoreLocation', 'MapKit', 'AVFoundation'
	s.requires_arc = true
end
