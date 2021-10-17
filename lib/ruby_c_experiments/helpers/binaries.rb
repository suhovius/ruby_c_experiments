require 'ffi'

module RubyCExperiments
  module Helpers
    module Binaries
      BINARY_EXTENSIONS = ['bundle', "#{::FFI::Platform::LIBSUFFIX}"].freeze

      class << self
        def for(binaries_dir_path, current_dir)
          library_path = File.expand_path(binaries_dir_path, current_dir)
          Dir.glob("#{library_path}.{#{BINARY_EXTENSIONS.join(',')}}")
        end
      end
    end
  end
end
