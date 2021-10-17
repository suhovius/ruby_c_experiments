# frozen_string_literal: true

# Binaries must be compiled in order use this module
# rake ruby_c_experiments:ffi:compile

require 'fiddle'

module RubyCExperiments
  module Fiddle
    module LevenshteinDistance
      class << self
        # This must be called first here as it defines 'binaries_list_for' method
        include ::RubyCExperiments::Helpers::Binaries

        define_method(:calculate) do |a, b|
          levenshtein.call(a, b)
        end

        private

        # Values are being cached here to avoid performance issues with
        # reinitialization of the reused values
        def lib_levenshtein
          @lib_levenshtein ||= ::Fiddle.dlopen(
            binaries_list_for('../binaries/ffi/levenshtein/levenshtein').first
          )
        end

        def levenshtein
          # C definition: size_t levenshtein(const char *a, const char *b) { ... }
          @levenshtein ||= ::Fiddle::Function.new(
            lib_levenshtein['levenshtein'],
            [::Fiddle::TYPE_CONST_STRING, ::Fiddle::TYPE_CONST_STRING],
            ::Fiddle::TYPE_SIZE_T
          )
        end
      end
    end
  end
end
