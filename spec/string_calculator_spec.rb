# frozen_string_literal: true

require 'string_calculator'
require 'errors/negative_integer_error'

# Test data
BASIC_CASES = {
  '' => 0,
  '1' => 1,
  '5' => 5,
  '1,5' => 6,
  '2,3' => 5
}.freeze

MULTIPLE_NUMBER_CASES = {
  '1,2,3' => 6,
  '1,2,3,4,5' => 15,
  '8,9,1,3' => 21
}.freeze

NEWLINE_DELIMITER_CASES = {
  "1\n2,3" => 6,
  "1,2\n,6" => 9,
  "1\n2\n3" => 6
}.freeze

CUSTOM_DELIMITER_CASES = {
  "//;\n1;2" => 3,
  "//|\n1|2|3" => 6,
  "//#\n2#5" => 7,
  "//.\n1.2.3.4" => 10
}.freeze

NEGATIVE_CASES = {
  '-1' => [-1],
  '1,-2,3,-4' => [-2, -4],
  "//;\n1;-2;3;-4" => [-2, -4],
  "1\n-2,3" => [-2]
}.freeze

EDGE_CASES = {
  ',' => 0,
  ',,' => 0,
  '1,,2' => 3,
  "1,\n2" => 3,
  "//;\n1;;2" => 3
}.freeze

LARGE_NUMBER_CASES = {
  '2,1001' => 2,
  '1000,1' => 1001,
  '999,1001,2' => 1001
}.freeze

LONG_DELIMITER_CASES = {
  "//[***]\n1***2***3" => 6,
  "//[%%]\n2%%3%%4" => 9,
  "//[!!]\n1!!1!!1" => 3
}.freeze

COMPLEX_DELIMITER_CASES = {
  '//[*][%]\n1*2%3' => 6,
  '//[***][%%]\n1***2%%3' => 6,
  '//[--][::]\n4--5::6' => 15
}.freeze

RSpec.describe StringCalculator do
  subject(:calculator) { described_class.new }

  # Shared example for testing multiple input/output pairs in order to remove duplication of code
  shared_examples 'calculates sum of the numbers string' do |test_inputs|
    test_inputs.each do |input, expected_output|
      it "returns #{expected_output} for input '#{input}'" do
        expect(calculator.add(input)).to eq(expected_output)
      end
    end
  end

  # Shared Example for negative numbers in the string.
  # We are defining and using a separate error class NegativeIntergerError for this.
  shared_examples 'raise the exception for negative numbers in the string' do |test_inputs|
    test_inputs.each do |input, negative_numbers|
      it "raises negative exception for input '#{input}'" do
        message = "negative numbers not allowed: #{negative_numbers.join(', ')}"
        expect { calculator.add(input) }.to raise_error(NegativeIntegerError, message)
      end
    end
  end

  describe '#add' do
    context 'empty, single and double numbers string' do
      include_examples 'calculates sum of the numbers string', BASIC_CASES
    end

    context 'multiple numbers in a string' do
      include_examples 'calculates sum of the numbers string', MULTIPLE_NUMBER_CASES
    end

    context 'newline delimiters in a string' do
      include_examples 'calculates sum of the numbers string', NEWLINE_DELIMITER_CASES
    end

    context 'different delimiters in a string' do
      include_examples 'calculates sum of the numbers string', CUSTOM_DELIMITER_CASES
    end

    context 'negative numbers' do
      include_examples 'raise the exception for negative numbers in the string', NEGATIVE_CASES
    end

    context 'edge cases' do
      include_examples 'calculates sum of the numbers string', EDGE_CASES
    end

    context 'numbers from 1001 are ignored' do
      include_examples 'calculates sum of the numbers string', LARGE_NUMBER_CASES
    end

    context 'delimiters of any length' do
      include_examples 'calculates sum of the numbers string', LONG_DELIMITER_CASES
    end

    context 'multiple and complex delimiters' do
      include_examples 'calculates sum of the numbers string', COMPLEX_DELIMITER_CASES
    end
  end
end
