# frozen_string_literal: true

require 'string_calculator'

RSpec.describe StringCalculator do
  subject(:calculator) { described_class.new }

  # Shared example for testing multiple input/output pairs in order to remove duplication of code
  shared_examples 'calculates sum of the numbers string' do |test_cases|
    test_cases.each do |input, expected_output|
      it "returns #{expected_output} for input '#{input}'" do
        expect(calculator.add(input)).to eq(expected_output)
      end
    end
  end

  describe '#add' do
    context 'empty, single and double numbers string' do
      include_examples 'calculates sum of the numbers string', {
        '' => 0,
        '1' => 1,
        '5' => 5,
        '1,5' => 6,
        '2,3' => 5
      }
    end

    context 'multiple numbers in a string' do
      include_examples 'calculates sum of the numbers string', {
        '1,2,3' => 6,
        '1,2,3,4,5' => 15,
        '8,9,1,3' => 21
      }
    end

    context 'newline delimiters in a string' do
      include_examples 'calculates sum of the numbers string', {
        "1\n2,3" => 6,
        "1,2\n,6" => 9
      }
    end

    context 'different delimiters in a string' do
      include_examples 'calculates sum of the numbers string', {
        "//;\n1;2" => 3,
        "//|\n1|2|3" => 6
      }
    end

    context 'negative numbers' do
      it 'throws exception for a negative number' do
        expect { calculator.add('-1') }.to raise_error(ArgumentError, 'negative numbers not allowed: -1')
      end

      it 'show all negative numbers in the exception message' do
        expect { calculator.add('1,-2,3,-4') }.to raise_error(ArgumentError, 'negative numbers not allowed: -2, -4')
      end
    end

    context 'edge cases' do
      include_examples 'calculates sum of the numbers string', {
        '1,,2' => 3,
        "//;\n1;;2" => 3
      }
    end
  end
end
