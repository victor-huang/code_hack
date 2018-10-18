

def find_common_chars_qnd(string1, string2)

  result = ""
  string1.each_char do |char|
    string2.each_char do |char2|
      if char == char2
        result << char
        break
      end
    end
  end
  return result
end

def  find_common_chars(string1, string2)
  hash = {}
  found_char = ""
  #populate the hash with all char found in string2
  string2.each_char do |char|
    hash[char] = 1
  end
  
  string1.each_char do |char|
    if hash.has_key? char
      found_char << char
    end
  end

  return found_char
end

if $0 == __FILE__
  str1 = "12 abcdefg _+"
  str2 =  "gl lop af +"
  
  p find_common_chars_qnd(str1, str2)
  p find_common_chars(str1, str2)
end
