# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "canpe/version"

Gem::Specification.new do |spec|
  spec.name          = "canpe"
  spec.version       = Canpe::VERSION
  spec.authors       = ["Yoshinori Kosaka"]
  spec.email         = ["yoshinori.ksk@gmail.com"]

  spec.summary       = 'customizable template generator written by Ruby.'
  spec.description   = ''
  spec.homepage      = 'https://github.com/ykosaka/canpe'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ['canpe']
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.20"
  spec.add_dependency "tilt", "2.0.8"
  spec.add_dependency "activesupport", "~> 5"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0"
  spec.add_development_dependency "pry-byebug", "~> 3.5"
  spec.add_development_dependency "awesome_print", "~> 1.8"
end
