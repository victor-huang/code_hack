
$max_level = 9

$recursion_level = 0
#quick sort with building new array for left and right sub array
def quick_sort( array )
  if array.size <= 1
    return array
  end
  
  pivoit_index = (( array.size - 1 )/2).floor 
  pivoit = array[ pivoit_index ]
  
  left_array = []
  right_array = []
  
  array.each_index do |index|
    if index != pivoit_index
      if array[index] <= pivoit 
        left_array.push(array[index])
      else
        right_array.push(array[index])
      end
    end
    
  end
  
  puts "==========Level #{$recursion_level}======="
  p pivoit
  p left_array
  p right_array
  puts "===================================="
 # if $max_level > 0
    $recursion_level += 1
    sorted_left = quick_sort(left_array)
    sorted_right = quick_sort(right_array)
  #end
  
  sorted_left.push(pivoit)
  
  return sorted_left + sorted_right
end

#the standar in place replacment methods
def quick_sort2(array, left, right)
  pivoit_index = ((right + left) / 2).floor
  pivoit = array[pivoit_index]
  
  new_left = left
  new_right = right
  
  while new_left <= new_right
    while array[new_left] < pivoit
      new_left += 1
    end
    while array[new_right] > pivoit
      new_right -= 1
    end
    
    if new_left <= new_right
      tmp = array[new_left]
      array[new_left] = array[new_right]
      array[new_right] = tmp
      new_left += 1
      new_right -= 1
    end
  end


  puts pivoit
  puts "left #{left} new_left #{new_left}, new_right #{new_right} right #{right}"
  p array

    if left < new_right
      quick_sort2(array, left, new_right )
    end
    
    if new_left < right
      quick_sort2(array, new_left , right)
    end


end


#not sure this will work
def quick_sort3(array, left, right)

  if left == right
    return
  end
  
  pivoit_index = ((right + left) / 2).floor
  pivoit = array[pivoit_index]
  
  new_left = left
  new_right = right
  
  while new_left <= new_right
    while array[new_left] < pivoit
      new_left += 1
    end
    while array[new_right] > pivoit
      new_right -= 1
    end
    
    if new_left <= new_right
      tmp = array[new_left]
      array[new_left] = array[new_right]
      array[new_right] = tmp
      new_left += 1
      new_right -= 1
    end
  end
  
  if array[new_left] == pivoit
    pivoit_index = new_left
  end
  
  if array[new_right] == pivoit
    pivoit_index = new_right
  end


  puts pivoit
  puts "left #{left} new_left #{new_left}, new_right #{new_right} right #{right}"
  p array

    quick_sort3(array, left, pivoit_index - 1)

    

    quick_sort3(array, pivoit_index + 1 , right)



end

if $0 == __FILE__
  test = []
  5.times do 
    test.push(rand(100))
  end
  
  p test
  p quick_sort3(test, 0, test.size - 1)
  p test
  p test.sort
end

