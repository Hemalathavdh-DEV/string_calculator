# frozen_string_literal: true

require 'string_calculator'

RSpec.describe StringCalculator do
  let(:calculator) { StringCalculator.new }

  describe '#add' do
    # Empty string should return 0
    it 'returns 0 for empty string' do
      expect(calculator.add('')).to eq(0)
    end

    # Single str value should return as single integer
    it 'returns the number itself for single number' do
      expect(calculator.add('1')).to eq(1)
      expect(calculator.add('5')).to eq(5)
    end

    # Sum the two numbers separated by comma
    it 'returns sum of two numbers separated by comma' do
      expect(calculator.add('1,5')).to eq(6)
      expect(calculator.add('2,3')).to eq(5)
    end

    # Sum the multiple numbers separated by comma
    it 'returns sum of multiple numbers' do
      expect(calculator.add('1,2,3')).to eq(6)
      expect(calculator.add('1,2,3,4,5')).to eq(15)
      expect(calculator.add('8,12,3,4,5')).to eq(32)
    end

    # Ignore new lines between numbers and do sum
    it 'handles newlines between numbers' do
      expect(calculator.add("1\n2,3")).to eq(6)
      expect(calculator.add("1,2\n,3")).to eq(6)
      expect(calculator.add("2,2\n,1")).to eq(5)
    end

    # Supports different delimiters
    it 'supports custom delimiters' do
      expect(calculator.add("//;\n1;2")).to eq(3)
      expect(calculator.add("//|\n1|2|3")).to eq(6)
    end

    # Negative numbers are not allowed and to throw error
    it 'throws exception for negative numbers' do
      expect { calculator.add('-1') }.to raise_error(ArgumentError, 'negative numbers not allowed: -1')
    end

    it 'handles empty values between delimiters' do
      expect(calculator.add('1,,2')).to eq(3)
      expect(calculator.add("//;\n1;;2")).to eq(3)
    end
  end
end
