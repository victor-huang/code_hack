

#return the prefix function array start with index 1, index 0 is not used and marked as -1 
def build_pattern_prefix_function(pattern)
  prefix_fnc_array = []
  prefix_fnc_array[0] = -1
  prefix_fnc_array[1] = 0
  k = 0 
  padded_pattern = " " + pattern # padded so that index 1 will point to the start of the pattern
  (2..pattern.size).each do |q|
    #while  padded_pattern[k+1] !=  padded_pattern[q]
      while k > 0 and padded_pattern[k+1] != padded_pattern[q]
        k = prefix_fnc_array[k]
      end
      if padded_pattern[k+1] == padded_pattern[q]
        k += 1
      end
      prefix_fnc_array[q] = k
    #end
  
  end
  return prefix_fnc_array
end

#this method will building the longest pre-fix from the begning every time
def slow_build_pattern_prefix_function(pattern)
  prefix_fnc_array = []
  prefix_fnc_array[0] = -1
  prefix_fnc_array[1] = 0
  padded_pattern = " " + pattern # padded so that index 1 will point to the start of the pattern
  
  (2..pattern.size ).each do |q|
    k = 0
    (1..q-1).each do |index|
          #puts "#{q} #{index} #{padded_pattern[1..index]}  #{padded_pattern[ q - index + 1 .. q]}    "
      if padded_pattern[1..index] == padded_pattern[ q - index + 1 .. q]     
        k = index 
      end
    end
    prefix_fnc_array[q] = k
  
  end

  return prefix_fnc_array
end

def kmp_string_matching(string, pattern)
  prefix_fnc_array = build_pattern_prefix_function(pattern)
  
  padded_pattern = " " + pattern
  q = 0
  (0..string.size - 1).each do |index|
    
    while q > 0 and padded_pattern[ q + 1] != string[index]
      q = prefix_fnc_array[q]
    end
    
    if padded_pattern[ q + 1] == string[index]
      q += 1
    end
    
    #found the string
    if q == pattern.size
      puts "String matched from index #{index - pattern.size + 1}  to #{index} :"+
        "#{string[index - pattern.size + 1..index]}"
      q = prefix_fnc_array[q]
    end
    
  end

end

if $0 == __FILE__
  #pattern = "ababababca"
  text ='totheworldtotoheretoooto'
  pattern = "abababababbabababaaaabbba"
  
  p build_pattern_prefix_function(pattern)
  p slow_build_pattern_prefix_function(pattern)
  kmp_string_matching(text, "to")
end