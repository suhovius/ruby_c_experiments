# frozen_string_literal: true

require 'spec_helper'

describe RubyCExperiments::LevensteinDistance do
  subject { described_class }

  describe '.calculate' do
    it_behaves_like 'Levenstein distance calculation', str_a: 'cat', str_b: 'bat', expected: 1

    it_behaves_like 'Levenstein distance calculation', str_a: 'cat', str_b: 'dog', expected: 3

    it_behaves_like 'Levenstein distance calculation', str_a: 'tractor', str_b: 'factor', expected: 2

    it_behaves_like 'Levenstein distance calculation', str_a: 'progress', str_b: 'congress', expected: 3

    it_behaves_like 'Levenstein distance calculation', str_a: 'inconsequential', str_b: 'essential', expected: 8

    it_behaves_like 'Levenstein distance calculation', str_a: 'essential', str_b: 'inconsequential', expected: 8
  end
end
