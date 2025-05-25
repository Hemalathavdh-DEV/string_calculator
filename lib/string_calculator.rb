# frozen_string_literal: true

class StringCalculator
  def add(numbers)
    delimiter, numbers_string = extract_delimiter_and_numbers(numbers)
    sum_of_numbers_string(numbers_string, delimiter)
  end

  private

  def extract_delimiter_and_numbers(input)
    return [',', input] unless input.start_with?('//')

    delimiter_line, numbers_string = input.split("\n", 2)
    delimiter = delimiter_line[2..-1] # Remove '//' prefix
    [delimiter, numbers_string || '']
  end

  # Add the numbers in the string and also handles the delimiter
  def sum_of_numbers_string(input, delimiter = ',')
    total = 0
    current = ''

    input.each_char do |char|
      char = delimiter if char == "\n"
      if char == delimiter
        total += current.to_i
        current = ''
      else
        current += char
      end
    end

    total + current.to_i
  end
end
