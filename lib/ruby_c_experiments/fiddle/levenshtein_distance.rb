# frozen_string_literal: true

# Binaries must be compiled in order use this module
# rake ruby_c_experiments:ffi:compile

require 'fiddle'
require 'fiddle/import'

# Read more here
# https://ruby-doc.org/stdlib-3.0.2/libdoc/fiddle/rdoc/Fiddle/Importer.html
# https://www.honeybadger.io/blog/use-any-c-library-from-ruby-via-fiddle-the-ruby-standard-librarys-best-kept-secret/
# https://medium.com/@astantona/fiddling-with-rubys-fiddle-39f991dd0565
module RubyCExperiments
  module Fiddle
    module LevenshteinDistance
      extend ::Fiddle::Importer

      library_path = ::RubyCExperiments::Helpers::Binaries.for(
        '../binaries/ffi/levenshtein/levenshtein', __dir__
      ).first

      dlload library_path

      extern 'size_t levenshtein(const char *a, const char *b)'
    end
  end
end
