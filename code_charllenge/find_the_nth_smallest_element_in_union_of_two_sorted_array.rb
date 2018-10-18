

def find_the_nth_element_in_union_of_two_sorted_array( array_a, array_b, n_th)

  mid_index_a = (array_a.size /2).floor
  mid_index_b = (array_b.size /2).floor
  a_lower = 0
  a_upper = array_a.size - 1
  b_lower = 0
  b_upper = array_b.size - 1
  while mid_index_a != 0 and mid_index_b != 0
    if array_a[mid_index_a] > array_b[mid_index_b]
      if (mid_index_a + mid_index_b + 2) > n_th
        #update the new index for the larger element array
        mid_index_a = (a_lower + mid_index_a  / 2).floor
        a_upper =  mid_index_a
      else (mid_index_a + mid_index_b + 2) < n_th
        mid_index_b = (b_upper + mid_index_b  / 2).floor
        b_lower =  mid_index_b
      end
    else array_a[mid_index_a] < array_b[mid_index_b]
      
    end
    
  end

end





if $0 == __FILE__

   array_a = []
   array_b = [] 
  5.times do |i| 
    val = rand(100)
    array_a.push(val)
    array_b.push(rand(100))
  end
  p array_a
  p array_b
  p (array_a | array_b).sort
end