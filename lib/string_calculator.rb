# frozen_string_literal: true

class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    numbers = parse_numbers(numbers)
    sum_of_numbers_string(numbers)
  end

  private

  # Replace newlines with commas, then split by comma
  def parse_numbers(numbers)
    numbers.gsub("\n", ',')
  end

  # Add the numbers in the string
  def sum_of_numbers_string(numbers)
    total = 0
    current = ''
    numbers.each_char do |char|
      unless char == ','
        current += char
        next
      end
      total += current.to_i
      current = ''
    end
    total + current.to_i
  end
end
