def find_integer_in_array(array, num, start_index, end_index)

  target_index = nil 
  if start_index == end_index
    if array[start_index] == num
      target_index = start_index
    end
    return target_index
  end
  
  middle_point_index = ((start_index + end_index)/2).floor
  
  if num == array[middle_point_index]
    target_index = middle_point_index
    
  elsif num < array[middle_point_index]
    #serach the left sub-array
    target_index = find_integer_in_array(array, num, start_index, middle_point_index - 1)
  elsif num > array[middle_point_index]
    target_index = find_integer_in_array(array, num, middle_point_index +1, end_index)
  end

  #find the first occurent of the index
  while target_index != 0 and !target_index.nil?
    if array[target_index - 1] != array[target_index]
      break
    end
    target_index -= 1
  end
  
  if target_index.nil?
    return -1
  end
  
  return target_index

end


if $0 == __FILE__

  test = []
  10.times do 
    test.push(rand(100))
  end
  test.sort!
  p test
  pick =  rand(10)
  puts "pick index  #{pick} , value #{test[pick]}"
  index = find_integer_in_array(test, test[pick], 0 , (test.size - 1) )
  p index
  puts "array[#{index}] is #{test[index]}"
end