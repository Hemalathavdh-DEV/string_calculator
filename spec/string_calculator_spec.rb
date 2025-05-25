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
  end
end
