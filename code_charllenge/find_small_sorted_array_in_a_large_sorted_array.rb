
def find_all_number_in_small_sroted_array_in_larger_sorted_array(s_array, l_array)

  if s_array.size < 0 or l_array.size <0
    puts "Both array can not be empty"
    return false
  end
  search_range_left_index = 0
  search_range_right_index = l_array.size - 1
  
  left_right_end_switch = 0
  small_in_large = true
  index = 0
  while index <= (s_array.size/2).floor and 
    !(s_array.size % 2 == 0 and index == (s_array.size/2).floor )
    if left_right_end_switch % 2 == 0
      #search the left most elm of the small array 
       puts "Seraching elm #{s_array[index]} " 
      search_range_left_index = find_a_number_in_sorted_array(s_array[index], l_array,
        search_range_left_index, search_range_right_index)
        puts "Left index updated to #{search_range_left_index}"
      #in the case of odd array  size we don't need to process the right end at the last iteration
      if s_array.size % 2 == 1 and index == (s_array.size/2).floor 
        index += 1
      end
    else
      puts "Seraching elm #{s_array[ s_array.size-1 - index]} " 
      #serach the right most elm of the small array
      search_range_right_index = find_a_number_in_sorted_array(
        s_array[ s_array.size-1 - index], l_array, search_range_left_index,
          search_range_right_index)
        puts "Right index updated to #{search_range_right_index}"
      index += 1 #only increase when we finish seraching both the lef and right
    end
    if search_range_left_index.nil? or search_range_right_index.nil?
      small_in_large = false
      break
    end
    left_right_end_switch += 1
  end

  return small_in_large
end

#return the index of the found element in array
def find_a_number_in_sorted_array(target_num, array, start_index, end_index)
  
  if end_index < start_index or start_index > end_index
    return nil
  end
  
  middle_index = ((start_index + end_index)/2).floor
  found_target_index = nil 
  
  if target_num < array[middle_index]
    found_target_index = find_a_number_in_sorted_array(target_num, array, start_index, middle_index - 1)
  elsif target_num > array[middle_index]
    found_target_index = find_a_number_in_sorted_array(target_num, array, middle_index + 1, end_index)
  else
    found_target_index =  middle_index
  end
  
  return found_target_index
end

if $0 == __FILE__
  test = []
  100.times do 
    test.push(rand(100))
  end
  #test = [0,0,1,1,1,1,3,3,3,4,4,6,6,9,10,15,15]
  #test = [0, 0, 0,1,1,5,6,6,9,9,9]
  test.sort!
  
  small_array =  test[4..50] | test[80..90] | [100]
  p small_array
  p test
  # p test
  # pick =  rand(10)
  # puts "pick index  #{pick} , value #{test[pick]}"
  # index = find_a_number_in_sorted_array( test[pick], test, 0 , (test.size - 1) )
  # p index
  # puts "array[#{index}] is #{test[index]}"
  
  p find_all_number_in_small_sroted_array_in_larger_sorted_array(small_array, test)


end