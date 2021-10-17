# frozen_string_literal: true

require 'spec_helper'

describe RubyCExperiments::Fiddle::LevenshteinDistance do
  it_behaves_like 'Levenshtein distance module', calculation_method_name: :calculate
end
