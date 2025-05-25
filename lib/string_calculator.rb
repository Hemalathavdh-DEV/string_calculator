# frozen_string_literal: true

class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    delimiter, numbers_string = extract_delimiter_and_numbers(numbers)
    numbers_string = parse_numbers(numbers_string, delimiter)
    sum_of_numbers_string(numbers_string, delimiter)
  end

  private

  def extract_delimiter_and_numbers(input)
    return [',', input] unless input.start_with?('//')

    delimiter_line, numbers_string = input.split("\n", 2)
    delimiter = delimiter_line[2..-1] # Remove '//' prefix
    [delimiter, numbers_string || '']
  end

  # Replace newlines with commas, then split by comma
  def parse_numbers(numbers, delimiter = ',')
    numbers.gsub("\n", delimiter)
  end

  # Add the numbers in the string
  def sum_of_numbers_string(numbers, delimiter = ',')
    total = 0
    current = ''
    numbers.each_char do |char|
      unless char == delimiter
        current += char
        next
      end
      total += current.to_i
      current = ''
    end
    total + current.to_i
  end
end
