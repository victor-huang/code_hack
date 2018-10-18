

##in place merge sort....not really, more like a bubble sort
#good things, constant space
def merge_sort_bubble(array, start_index, end_index)

  if start_index == end_index
    return
  end
  partition_point = ((start_index + end_index ) / 2).floor #ensure the left subarry is smaller

  #sort left sub-array
  merge_sort_bubble( array, start_index, partition_point )
  merge_sort_bubble( array, partition_point + 1 , end_index)
  
  #merge step 
  right_array_cur = end_index 

  while right_array_cur >= ( partition_point + 1)
    if array[partition_point] < array[right_array_cur]
      #do nothing
    else
      #swap the larger element up
      tmp = array[partition_point] 
      array[partition_point]  = array[right_array_cur]
      array[right_array_cur] = tmp
      
      #element swap in the right sub array , need to matain it's local sort order
      maintain_sort(array, start_index, partition_point)
    end
  
    right_array_cur  -= 1
  end


end

def maintain_sort(array, start, end_index)
  i = end_index
  while i > start
 # (start..(end_index-1)).each do |i|
    if array[i] < array[i - 1]
      tmp = array[i] 
      array[i] = array[i - 1]
      array[i - 1] = tmp
    else
      break
    end
    i -= 1
  end

end


#this merge sort creates n^2 additional arrays
#building extrat arrays
def merge_sort_with_extra_arrays(array)

  if array.size <= 1
    return array
  end
  
  partition = ((array.size - 1 ) / 2).floor 
  
  left_array = []
  right_array = []
  sorted_array = []
  
  array.each_index do |index|
    if index <= partition
      left_array.push(array[index])
    else
      right_array.push(array[index])
    end
  
  end

  left_array = merge_sort_with_extra_arrays(left_array)
  right_array = merge_sort_with_extra_arrays(right_array)

  index = 0
  r_index = 0
  times = 0
  while (index + r_index)  < array.size
    # puts "left #{index} right #{index}, #{left_array.size + right_array.size}"
    # p left_array
    # p right_array
    # p sorted_array
    if index < left_array.size and r_index < right_array.size
      if left_array[index] <= right_array[r_index]
        sorted_array.push(left_array[index])
        index += 1 
      else
        sorted_array.push(right_array[r_index])
        r_index += 1
      end
    elsif index == (left_array.size ) and r_index < right_array.size
      sorted_array.push(right_array[r_index])
      r_index += 1
    elsif r_index == (right_array.size ) and index < left_array.size
      sorted_array.push(left_array[index])
      index += 1
    end
  end
  return sorted_array
end


#the official algorithm in text book
def merge_sort(array, start_index, end_index)

  if start_index == end_index
    return [ array[start_index] ]
  end
  partition_point = ((start_index + end_index ) / 2).floor #ensure the left subarry is smaller

  #sort left sub-array
  left_array = merge_sort( array, start_index, partition_point )
  right_array = merge_sort( array, partition_point + 1 , end_index)
  
  #merge step 
  new_array = []

  while  left_array.size > 0 or right_array.size >0
    if !left_array.empty? and !right_array.empty?
      if left_array[0] >= right_array[0]
        new_array.push( right_array.delete_at(0) )
        
      else
        new_array.push( left_array.delete_at(0) )
        
      end
    elsif !left_array.empty?
    
      new_array.push( left_array.delete_at(0) )
      
      
    elsif !right_array.empty?
    
      new_array.push( right_array.delete_at(0) )

    end
  end

  return new_array

end



if $0 == __FILE__
  test = []
  10.times do 
    test.push(rand(100))
  end
  test2 = test.dup
  test3 = test.dup
  p test
  t_start = Time.now.to_f * 1000
     test.sort! 
  t_end = Time.now.to_f * 1000  
  puts "Time used #{t_end - t_start} "
  t_start = Time.now.to_f * 1000
  merge_sort_bubble(test2, 0, test2.size - 1)
  t_end = Time.now.to_f * 1000  
  puts "Time used #{t_end - t_start} "
  
  t_start = Time.now.to_f * 1000
  p merge_sort(test3, 0, test3.size-1)
    t_end = Time.now.to_f * 1000  
  
  puts "Time used #{t_end - t_start} "
  p test
 # p test
  #p test2
end