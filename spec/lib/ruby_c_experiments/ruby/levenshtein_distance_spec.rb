# frozen_string_literal: true

require 'spec_helper'

describe RubyCExperiments::Ruby::LevenshteinDistance do
  context 'wikipedia algorithm' do
    it_behaves_like 'Levenshtein distance module', calculation_method_name: :with_wikipedia_algorithm
  end

  context 'rubygems algorithm' do
    it_behaves_like 'Levenshtein distance module', calculation_method_name: :with_rubygems_algorithm
  end
end
