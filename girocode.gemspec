lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'girocode/version'

Gem::Specification.new do |s|
  s.name          = 'girocode'
  s.version       = Girocode::VERSION
  s.authors       = ['Matthias Grosser']
  s.email         = ['mtgrosser@gmx.net']

  s.summary       = %q{Generate QR codes for SEPA credit transfers}
  s.description   = %q{EPC QR code for SEPA payments in any format}
  s.homepage      = 'https://github.com/mtgrosser/girocode'
  s.licenses      = ['MIT']

  s.files         = Dir['{lib}/**/*.rb', 'LICENSE', 'README.md', 'CHANGELOG.md']
  s.require_paths = ['lib']

  s.add_dependency 'rqrcode'
  s.add_dependency 'bank-contact'
end
