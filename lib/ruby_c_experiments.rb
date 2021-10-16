# frozen_string_literal: true

require 'ruby_c_experiments/version'
require 'ruby_c_experiments/error'

# In order to let these files to be required
# these extensions must be compiled beforehand first with this command
# rake ruby_c_experiments:native:compile
require 'ruby_c_experiments/binaries/native/levenshtein_distance/levenshtein_distance'

require 'ruby_c_experiments/ruby/levenshtein_distance'
require 'ruby_c_experiments/inline/levenshtein_distance'

require 'ruby_c_experiments/ffi/levenshtein_distance'

# Main module for this gem
module RubyCExperiments
  # Some other ruby code might be here
end
