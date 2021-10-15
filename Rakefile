# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/extensiontask'

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

EXT_LIB_DIR = 'lib/ruby_c_experiments/native'

ext_lib_dir = ->(ext_name) { [EXT_LIB_DIR, ext_name].join('/') }

Rake::ExtensionTask.new('levenshtein_distance') do |ext|
  # Setting lib_dir places the shared library in
  # lib/ruby_c_experiments/levenshtein_distance/levenshtein_distance.so (or .bundle or .dll)
  ext.lib_dir = ext_lib_dir.call('levenshtein_distance') # put binaries into this folder.
  # ext.ext_dir = 'ext/levenshtein_distance' # search for C sources by default
end
