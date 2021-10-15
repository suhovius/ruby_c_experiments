# frozen_string_literal: true

RSpec.shared_examples_for 'Levenshtein distance calculation' do |str_a:, str_b:, expected:|
  # let(:calculator) { ... } # lambda that calls the distance calculation logic must be defined before the call
  # Example: let(:calculator) { ->(str_a, str_b) { described_class.calculate(str_a, str_b) } }

  it "calculates distance between '#{str_a}' and '#{str_b}' to be equal to #{expected}" do
    # calculator lambda must be defined before the spec call
    expect(calculator.call(str_a, str_b)).to eql expected
  end
end

RSpec.shared_examples_for 'Levenshtein distance module' do |calculation_method_name:|
  # let(:calculator) { ... } # lambda that calls the distance calculation logic must be defined before the call
  let(:calculator) { ->(str_a, str_b) { described_class.public_send(calculation_method_name,str_a, str_b) } }

  describe ".#{calculation_method_name}" do
    it_behaves_like 'Levenshtein distance calculation', str_a: 'cat', str_b: 'bat', expected: 1

    it_behaves_like 'Levenshtein distance calculation', str_a: 'cat', str_b: 'dog', expected: 3

    it_behaves_like 'Levenshtein distance calculation', str_a: 'tractor', str_b: 'factor', expected: 2

    it_behaves_like 'Levenshtein distance calculation', str_a: 'progress', str_b: 'congress', expected: 3

    it_behaves_like 'Levenshtein distance calculation', str_a: 'inconsequential', str_b: 'essential', expected: 8

    it_behaves_like 'Levenshtein distance calculation', str_a: 'essential', str_b: 'inconsequential', expected: 8
  end
end
