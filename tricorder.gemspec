# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative "lib/version"

Gem::Specification.new do |spec|
  spec.name          = "tricorder"
  spec.version       = Tricorder::VERSION::STRING
  spec.authors       = ["Joel Bryan Juliano"]
  spec.email         = ["joelbryan.juliano@gmail.com"]

  spec.summary       = %q{A Domain-Specific Language for Star Trek API (http://stapi.co)}
  spec.description   = %q{A Domain-Specific Language for Star Trek API (http://stapi.co)}
  spec.homepage      = "https://github.com/jjuliano/tricorder"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting "allowed_push_host", or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler"
  spec.add_dependency "awesome_print"
  spec.add_dependency "json"
  spec.add_dependency "thor"
  spec.add_development_dependency "byebug"
end