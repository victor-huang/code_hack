# Complete the function below.

require 'pry'

def isPangram(strings)

  result = ''
  seen_chars = {}
  is_letter_regex = /[a-z]/

  strings.each do |str|
    str.each_char { |char| seen_chars[char] = 1 }

    seen_alphabets = seen_chars.keys.find_all { |char| is_letter_regex.match(char) }

    result += seen_alphabets.size == 26 ? '1' : '0'

    # reset seen_chars
    seen_chars = {}
  end

  result
end


def test

  arrays = [
  'we promptly judged antique ivory buckles for the next prize'
  ]


  puts isPangram(arrays)
end

test()
