# frozen_string_literal: true

require_relative 'errors/negative_integer_error'

class StringCalculator
  def add(numbers)
    delimiter, numbers_string = extract_delimiter_and_numbers(numbers)
    number_array = parse_numbers(numbers_string, delimiter)
    validate_no_negatives(number_array)

    number_array.sum
  end

  private

  def extract_delimiter_and_numbers(input)
    return [',', input] unless input.start_with?('//')

    delimiter_line, numbers_string = input.split("\n", 2)
    delimiter = delimiter_line[2..-1] # Remove '//' prefix
    [delimiter, numbers_string || '']
  end

  # Handles the delimiter
  def parse_numbers(numbers_string, delimiter = ',')
    normalized = numbers_string.gsub("\n", delimiter)
    normalized.split(delimiter)
              .map(&:strip)
              .reject(&:empty?)
              .map(&:to_i)
  end

  def validate_no_negatives(numbers)
    negatives = numbers.select(&:negative?)

    return if negatives.empty?

    raise NegativeIntegerError, "negative numbers not allowed: #{negatives.join(', ')}"
  end
end
