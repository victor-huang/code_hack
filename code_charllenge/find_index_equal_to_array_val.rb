
def find_array_index_equal_to_its_value(int_array)
  index = 0
  while (index < int_array.size)
    if index == int_array[index]
      puts "Find target #{int_array[index]} "
      index += 1
    elsif index < int_array[index]
    
      index = int_array[index]
      
    else
    
      index +=1 
    end
  
  end


end




if $0 == __FILE__

  test_array=[
    [],
    [1,2,3,4],
    [0,5,5,5,5,5,5,6],
    [0,1,2,3,4,5],
    [-5, -3, -2, -1, 0 , 5, 6,8,8,8]
    
  ]
  test_array.each do |array|
    puts "Testing array index: "
    array.each_index { |i| print i.to_s + ","}
    puts 
    puts "Testing array value: "
    puts "#{array.join(",")}"
    find_array_index_equal_to_its_value(array)
  end
end