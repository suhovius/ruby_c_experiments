# frozen_string_literal: true

# Binaries must be compiled in order use this module
# rake ruby_c_experiments:ffi:compile

require 'ffi'

module RubyCExperiments
  module FFI
    module LevenshteinDistance
      extend ::FFI::Library

      library_paths = ::RubyCExperiments::Helpers::Binaries.for(
        '../binaries/ffi/levenshtein/levenshtein', __dir__
      )
      # Try loading in order.
      ffi_lib library_paths

      # C definition: size_t levenshtein(const char *a, const char *b) { ... }
      attach_function :calculate, :levenshtein, [:string, :string], :size_t
    end
  end
end
