# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bai_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "bai_parser"
  spec.version       = BaiParser::VERSION
  spec.authors       = ["Sanjiv Patel"]
  spec.email         = ["sanjp2.0@gmail.com"]
  spec.description   = %q{Ruby BAI2 Bank File parser}
  spec.summary       = %q{Takes a bank file as input and outputs the data as a Ruby hash.  You can then use a custom writer class to output the data as needed for your purposes.}
  spec.homepage      = "https://github.com/sanjp/bai_parser"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
