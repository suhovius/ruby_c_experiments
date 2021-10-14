# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/extensiontask'

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

Rake::ExtensionTask.new('levenstein_distance') do |ext|
  # Setting lib_dir places the shared library in
  # lib/ruby_c_experiments/levenstein_distance/levenstein_distance.so (or .bundle or .dll)
  ext.lib_dir = 'lib/ruby_c_experiments/levenstein_distance' # put binaries into this folder.
  # ext.ext_dir = 'ext/levenstein_distance' # search for C sources by default
end
