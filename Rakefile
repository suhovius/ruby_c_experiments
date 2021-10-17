# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/extensiontask'

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

LIB_DIR = 'lib/ruby_c_experiments/binaries'

namespace :ruby_c_experiments do
  make_path = ->(folders) { folders.join('/') }

  namespace :native do
    lib_dir_prefix = [LIB_DIR, 'native']

    Rake::ExtensionTask.new('levenshtein_distance') do |ext|
      ext.lib_dir = make_path.call([lib_dir_prefix, ext.name])
    end
  end

  # BTW https://github.com/ffi/ffi-compiler can also be used for compilation
  # and inclusion of ffi libraries instead for rake-compiler as it is done here
  namespace :ffi do
    lib_dir_prefix = [LIB_DIR, 'ffi']

    Rake::ExtensionTask.new('levenshtein') do |ext|
      ext.lib_dir = make_path.call([lib_dir_prefix, ext.name])
    end
  end

  namespace :all do
    desc 'Compile all native and ffi extensions'
    task :compile do
      Rake::Task['ruby_c_experiments:ffi:compile'].invoke
      Rake::Task['ruby_c_experiments:native:compile'].invoke
    end
  end
end

# Load Rake tasks defined in the gem
path = File.expand_path(__dir__)
Dir.glob("#{path}/lib/tasks/**/*.rake").each { |f| import f }
