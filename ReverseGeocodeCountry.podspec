Pod::Spec.new do |s|
  s.name         = "ReverseGeocodeCountry"
  s.version      = "1.1"
  s.summary      = "A static country code reverse geocoding."
  s.description  = "Geocoding is performed offline using data from a provided JSON file."
  s.homepage     = "https://github.com/andris-lejasmeiers/ios-offline-reverse-geocode-country"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Rakshith" => "rakf1@hotmail.com", "andris-lejasmeiers" => "" }
  s.ios.deployment_target = "5.0"
  s.source       = { :git => "https://github.com/andris-lejasmeiers/ios-offline-reverse-geocode-country.git", :tag => "1.1" }
  s.source_files = "ReverseGeocodeCountry/ReverseGeocodeCountry.{h,m}"
  s.framework    = "CoreLocation"
  s.requires_arc = true
end