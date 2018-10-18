
#swaping a string in place

def swap_string( string )
  #swap the entire string once
  swap_substring(string, 0, string.size - 1)
  #swap each of the word one more time to get the word in correct ordere
  word_start_index = 0

  (0..string.size).each do |index|
    if index == string.size or ""<<string[index] == " "
      swap_substring(string, word_start_index, index - 1)
      word_start_index = index + 1
    end
    
  end

  return string
end

#swaping a substring given start and end_index, chnage string inplace
def swap_substring(string, start_index, end_index)
  return string if string.size <= 0
  
  (start_index .. (start_index + end_index)/2).each do |index|
    string[index], string[ start_index + end_index - index ] =
      string[ start_index + end_index - index ], string[index]
  end

  return string
end


if $0 == __FILE__

  p swap_substring("12345", 0 , 4)
  p swap_substring("1234", 0 , 3)
  #p swap_substring("", 0 ,0 )
  p swap_substring("12 5 0 6 79", 0, 10)
  str = "i'm the one."
  p swap_string(str)
  str = "word1 word2 word3 word4"
  p swap_string(str)
  str = "  word1 word2   word3      word4 _^_  "
  p swap_string(str)
  str = "vic is best"
  p swap_string(str)
  
end