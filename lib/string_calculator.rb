# frozen_string_literal: true

class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    sum_of_numbers_string(numbers)
  end

  private

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
