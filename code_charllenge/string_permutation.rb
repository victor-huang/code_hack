

#return an array of all the permutation of characters of a given string
def string_permute(str)
  
  
  if str.size <= 1
    return [str]
  end

  new_permutations = []
  all_permutations_of_smaller_str = string_permute(str[0..str.size-2])
  last_char = str[str.size-1]
  all_permutations_of_smaller_str.each do |permutation|
    (0..permutation.size).each do |index|
      new_copy = String.new(permutation)
      #create new permutation with the new charater added in
      new_permutations.push(new_copy.insert(index, ""<<last_char))
    end
  end

  return new_permutations
end

def swap(str, x, y)
  str2 = String.new(str)
  str2[x], str2[y] = str2[y], str2[x]
  
  return str2
end
def string_permute_fast(str, place, all_per)

  if str.size - 1 == place
    all_per.push(str)
    return
  end
  
  (place..str.size-1).each do |index|
    swaped_str = swap(str, place, index)
    string_permute_fast(swaped_str, place+1 , all_per)
  end


end


if $0 == __FILE__
word = "abcefghij"
time1 = Time.now.to_f
 per = string_permute(word)
time2 = Time.now.to_f
p per.size
puts "Time used :#{time2- time1} "


time1 = Time.now.to_f
p_set = []
string_permute_fast(word, 0 ,p_set)

#p p_set
time2 = Time.now.to_f
puts "Time used :#{time2- time1} "
# per2 = (word.chars.to_a.permutation.map &:join)

#p per == per2

end