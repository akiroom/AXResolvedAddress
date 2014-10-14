#
# Be sure to run `pod lib lint AXResolvedAddress.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AXResolvedAddress"
  s.version          = "0.1.0"
  s.summary          = "AXResolvedAddress is easy way to get NSNetService#addresses result."
  s.description      = <<-DESC
                       AXResolvedAddress is easy way to get NSNetService#addresses result.

                       ```
                       NSNetService *netService;
                       [AXResolvedAddress addressesWithNetServiceAddresses:netService.addresses];
                       ```
                       DESC
  s.homepage         = "https://github.com/akiroom/AXResolvedAddress"
  s.license          = 'MIT'
  s.author           = { "Hiroki Akiyama" => "aki-hiroki@nifty.com" }
  s.source           = { :git => "https://github.com/akiroom/AXResolvedAddress.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/akiroom'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  #s.resource_bundles = {
  #    'AXResolvedAddress' => ['Pod/Assets/*.png']
  #  }
end
