

#expecting an array of integer, 1,2,3...n following by a ,b ,c ...N , both integer and charater sequence 
#have the same size, the new reorder array will have the form of "1a, 2b, 3c ...nN". have to do it place
def element_reorde(array)
  if array.size <4
    return array
  end
  
  
  char_elm_start_index = array.size / 2
  next_index_to_swap = char_elm_start_index - 1
  (0..(array.size-4)).step(2) do |index|
    tmp_current_char_index = char_elm_start_index
    while next_index_to_swap > index
      #bubble up the first elm of the char sequence next to the current index
      #swaping two elements
      array[next_index_to_swap], array[tmp_current_char_index] =
        array[tmp_current_char_index], array[next_index_to_swap]
      next_index_to_swap -= 1
      tmp_current_char_index -= 1
    
    end
    char_elm_start_index += 1
    next_index_to_swap = char_elm_start_index - 1
  end

  return array
end


if $0 == __FILE__
  test = []
  20.times do |i|
    test.push(rand(100))
  end
  
  20.times do |i|
    test.push( ""<<(rand(24) + 65))
  end
  
  p test
  p element_reorde(test)

end



