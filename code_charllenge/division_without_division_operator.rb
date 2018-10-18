

#this file contains problem that use the division but without using the division operator

#dividend, divisor are positve integer
def divide_by_subtraction(dividend, divisor)
  #puts "#{dividend}/#{divisor} is :"
  quotient = 0 
  remainder = 0
  if dividend < divisor
    return [ 0, dividend]
  elsif divisor == 0 #can't do division by zero
    return nil
  else
    while dividend - divisor >= divisor
      dividend = dividend - divisor
      quotient += 1
    end
    
    if dividend != 0
      remainder = dividend - divisor
      quotient += 1
    end
    
    return [ quotient , remainder]
  end


end

def divide_by_bit_shift(dividend, divisor)
  
  ori_divisor = divisor
  #puts "#{dividend}/#{divisor} is :"
  quotient = 1 
  
  if dividend < divisor
    return [ 0 ,dividend]
  elsif dividend == divisor
    return [ 1, 0]
  elsif divisor == 0
    return nil
  end
   
  while dividend > (divisor <<= 1)
    quotient <<= 1
  end
  
  next_iteration_result = divide_by_bit_shift( dividend - (divisor >>= 1) , ori_divisor)
  
  return [quotient + next_iteration_result[0], next_iteration_result[1]]

end

#using subtraction
def mutiply_all_element_of_an_array_excep_itself(array_n)
  total_mutiplication_value = 1
  result_array = []
 
  array_n.each do |elm|
    total_mutiplication_value = elm * total_mutiplication_value
  end
  
  puts "Total mutiplication : #{total_mutiplication_value}"
  
  array_n.each do |elm|
    result = divide_by_subtraction(total_mutiplication_value, elm)
    result_array.push(result[0])
  end
  

  return result_array
end

#usng the bitshift way
def mutiply_all_element_of_an_array_excep_itself2(array_n)
  total_mutiplication_value = 1
  result_array = []
 
  array_n.each do |elm|
    total_mutiplication_value = elm * total_mutiplication_value
  end
  
  puts "Total mutiplication : #{total_mutiplication_value}"
  
  array_n.each do |elm|
    result = divide_by_bit_shift(total_mutiplication_value, elm)
    result_array.push(result[0])
  end
  

  return result_array
end


if $0 == __FILE__
  array = []
  5.times do |i|
    array.push(rand(9) + 1)
  end
  p array 
  
  p mutiply_all_element_of_an_array_excep_itself(array)
  p mutiply_all_element_of_an_array_excep_itself2(array)
   # p divide_by_bit_shift(10, 2)
   # p divide_by_bit_shift(5, 2)
   # p divide_by_bit_shift(11, 3)
end