require 'ffi'

module RubyCExperiments
  module Helpers
    module Binaries
      BINARY_EXTENSIONS = ['bundle', "#{::FFI::Platform::LIBSUFFIX}"].freeze

      def binaries_list_for(binaries_dir_path)
        library_path = File.expand_path(binaries_dir_path, __dir__)
        Dir.glob("#{library_path}.{#{BINARY_EXTENSIONS.join(',')}}")
      end
    end
  end
end
