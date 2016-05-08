# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name          = 'mail_guard'
  s.version       = '0.0.1'
  s.date          = '2016-05-08'
  s.summary       = "Protect your emails from getting sent."
  s.description   = "A simple interceptor that protects your emails from actually getting send."
  s.authors       = ["Sirko Sittig"]
  s.email         = ["info@schmierkov.de"]
  s.homepage      = "http://github.com/schmierkov/mail_guard"
  s.license       = "MIT"
  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.require_paths = ["lib"]
  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "minitest", ">= 3"
  s.add_development_dependency "appraisal"
end
