# frozen_string_literal: true

RSpec.shared_examples_for 'Levenstein distance calculation' do |str_a:, str_b:, expected:|
  it "calculates distance between '#{str_a}' and '#{str_b}' to be equal to #{expected}" do
    expect(subject.calculate(str_a, str_b)).to eql expected
  end
end
