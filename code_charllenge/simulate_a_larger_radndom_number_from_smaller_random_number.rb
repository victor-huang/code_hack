
#sumulate a randomnumber of from  range from 0-9, from a random number generator of 0-4
def simulate_rand_9_with_rand_4()

  result_num = nil
  base_rand = 5
  while (rand_num = rand(base_rand) * base_rand + rand(base_rand)) > 30
  
  end
  
  result_num = rand_num % 10
  result_num 
end

#simulate range from (1- 9 ) base on the random number generator of (1-4)
def simulate_rand_9_from_rand_4_start_wtih_1()
  base_rand = 4 
  target_base = 9 
  result_num = nil
  num = 9999
  while (num > 81)
     num = base_rand ** 2 * (rand(base_rand-1)) +
           base_rand ** 1 * (rand(base_rand-1)) + 
           (rand(base_rand-1) + 1)
  end
  result_num = num % target_base + 1
  result_num 
end

if $0 == __FILE__

  20.times do |time|
    #p simulate_rand_9_with_rand_4()
    p simulate_rand_9_from_rand_4_start_wtih_1
  end
  puts "--------------------"
  20.times do |time|
    #p simulate_rand_9_with_rand_4()
    p rand(9) + 1
  end
  
end


