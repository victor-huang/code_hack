
#dynamic programming to solve the the probelem
#
class Object
   def deep_copy( object )
     Marshal.load( Marshal.dump( object ) )
   end
end

#except coin_set to be sorte from small to large, and total_acmount is express in the mimium coin base
def find_the_minium_coin_changes( coin_set, total_amount)
  base_case = [1]
  base_case.fill(0, 1..coin_set.size-1)
  minium_coin_changes = [[].fill(0, 0..coin_set.size-1) ,base_case]
  
  coin_change_table = []
  (0 .. coin_set.size).each do |c_set_index|
    coin_change_table[c_set_index] = [0, 1] #base initialzation
  end

  (0 .. total_amount).each do |amount_index|
    coin_change_table[0][amount_index] = 0
  end
  
  #build the minium # of coins change table
  (2 .. total_amount).each do |amount|
    (0..coin_set.size-1).each do |c_set_index|
       
      sub_problem_amount = amount - coin_set[c_set_index]
      if sub_problem_amount < 0 
        #look for the smaller conin_set, which have been caculated
        coin_change_table[c_set_index + 1][amount] = coin_change_table[c_set_index][amount]
      else
        sub_problem_minimum_coin_changes = array_sum(minium_coin_changes[sub_problem_amount])
        coin_change_table[c_set_index + 1][amount] = 1 + sub_problem_minimum_coin_changes
      end

    end
    #find the mimium con change for the current amount
    minium_change = coin_change_table[1][amount]
    coin_set_type_index = 0
    (1..coin_set.size).each do |c_set_index|
      if minium_change > coin_change_table[c_set_index] [amount]
        minium_change = coin_change_table[c_set_index][amount] #get the min value
        coin_set_type_index = c_set_index - 1 #get the right coin set type
      end
    end
    
    #update the new minium coinset change for the current amount
    new_minium_coin_changes = deep_copy(minium_coin_changes[amount - coin_set[coin_set_type_index]])
    new_minium_coin_changes[coin_set_type_index] += 1
    minium_coin_changes[amount] = new_minium_coin_changes
  end
  
  #p minium_coin_changes

 
  #debug info
  #(0 .. coin_set.size).each do |c_set_index|
    #p coin_change_table[c_set_index] 
  #end
  
  return minium_coin_changes[-1]
end

#array is in integer array 
#get teh sum of all interger in an array, 
def array_sum(array)
  sum =0 
  array.each do |elm|
    sum += elm.to_i
  end

  return sum
end


if $0 == __FILE__

  coin_bases = [1,3,10,30,75]
  total_amount = 45
  puts "Coin bases: " + coin_bases.inspect
  
  puts "Total: " + total_amount.to_s
  p find_the_minium_coin_changes(coin_bases, total_amount)
  
  
end