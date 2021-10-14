# frozen_string_literal: true

RSpec.shared_examples_for 'Levenstein distance calculation' do |str_a:, str_b:, expected:|
  it "calculates distance between '#{str_a}' and '#{str_b}' to be equal to #{expected}" do
    expect(subject.calculate(str_a, str_b)).to eql expected
  end
end

RSpec.shared_examples_for 'Levenstein distance module' do
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
