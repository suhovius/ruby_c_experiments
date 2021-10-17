# frozen_string_literal: true

# Binaries must be compiled in order use this module
# rake ruby_c_experiments:ffi:compile

require 'ffi'

module RubyCExperiments
  module FFI
    module LevenshteinDistance
      # This must be called first here as it defines 'binaries_list_for' method
      extend ::RubyCExperiments::Helpers::Binaries

      extend ::FFI::Library

      # Try loading in order.
      ffi_lib(binaries_list_for('../binaries/ffi/levenshtein/levenshtein'))

      # C definition: size_t levenshtein(const char *a, const char *b) { ... }
      attach_function :calculate, :levenshtein, [:string, :string], :size_t
    end
  end
end
