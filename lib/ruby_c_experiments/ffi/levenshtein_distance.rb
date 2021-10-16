# frozen_string_literal: true

# Binaries must be compiled in order use this module
# rake ruby_c_experiments:ffi:compile

require 'ffi'

module RubyCExperiments
  module FFI
    module LevenshteinDistance
      # class << self
      #   def calculate(a, b)

      #   end
      # end
      BINARY_EXTENSIONS = ['bundle', "#{::FFI::Platform::LIBSUFFIX}"].freeze

      class << self
        def binaries_list_for(binaries_dir_path)
          library_path = File.expand_path(binaries_dir_path, __dir__)
          Dir.glob("#{library_path}.{#{BINARY_EXTENSIONS.join(',')}}")
        end
      end

      extend ::FFI::Library

      # Try loading in order.
      ffi_lib(binaries_list_for('../binaries/ffi/levenshtein/levenshtein'))

      # C definition: size_t levenshtein(const char *a, const char *b) { ... }
      attach_function :calculate, :levenshtein, [:string, :string], :size_t
    end
  end
end
