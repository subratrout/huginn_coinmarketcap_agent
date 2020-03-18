# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "huginn_coinmarketcap_agent"
  spec.version       = '0.3'
  spec.authors       = ["Subrat Rout"]
  spec.email         = ["subratnrout@gmail.com"]

  spec.summary       = %q{The huginn_coinmarketcap_agent extracts market price of all cryptocurrencies and tokens that are avialble on coinmarketcap site using coinmarketcap API}

  spec.homepage      = "https://github.com/subratrout/huginn_coinmarketcap_agent"

  spec.license       = "MIT"


  spec.files         = Dir['LICENSE.txt', 'lib/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = Dir['spec/**/*.rb'].reject { |f| f[%r{^spec/huginn}] }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "rake", "~> 12.3.3"

  spec.add_runtime_dependency "huginn_agent"
end
