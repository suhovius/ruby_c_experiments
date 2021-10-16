# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_c_experiments/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby_c_experiments'
  spec.version       = RubyCExperiments::VERSION
  spec.date = '2021-10-12'
  spec.authors       = ['Oleksii Sukhovii']
  spec.email         = ['alexey.suhoviy@gmail.com']

  spec.summary       = 'Demo gem with Ruby C Extensions and Foreign Function Interface (FFI)'
  spec.description   = 'Ruby gem that provides examples of Ruby C Extensions and Foreign Function Interface (FFI)'
  spec.homepage      = 'https://github.com/suhovius/ruby_c_experiments'

  spec.license = 'MIT'

  spec.required_ruby_version = '>= 3.0.2'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/suhovius/ruby_c_experiments'
    spec.metadata['changelog_uri'] = 'https://github.com/suhovius/ruby_c_experiments'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir['{lib,ext}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  spec.require_paths = ['lib']

  # Add extension paths to extensions list
  spec.extensions += Dir['ext/**/extconf.rb']

  spec.add_dependency 'RubyInline', '~> 3.12.5'
  spec.add_dependency 'ffi', '~> 1.15.4'

  spec.add_development_dependency 'bundler', '~> 2.2.29'
  spec.add_development_dependency 'rake', '~> 13.0.6'
  spec.add_development_dependency 'rake-compiler', '~> 1.1.1'
  spec.add_development_dependency 'rspec', '~> 3.10.0'
  spec.add_development_dependency 'benchmark-ips', '~> 2.9.2'
end
