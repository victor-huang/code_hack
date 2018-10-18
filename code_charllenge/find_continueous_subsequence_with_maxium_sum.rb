
def fine_continue_subsequence_with_maxium_sum(array)
  sub_sequence_start_index = 0
  sub_sequence_end_index = 0 
  sub_sequence_sum = array[0]
  sub_sequence_start_index_last = 0
  sub_sequence_end_index_last = 0 
  sub_sequence_sum_last= array[0]
  
  (1..array.size-1).each do |index|
    
    #add one elmement ot the sub-sequence ending with the array without the current elm
    #puts sub_sequence_start_index_last.to_s
    puts " sum #{sub_sequence_sum_last.to_s} sum+elm #{(sub_sequence_sum_last + array[index]).to_s} elm:#{array[index].to_s} "
    if sub_sequence_sum_last + array[index] > array[index] 
 
      sub_sequence_end_index_last = sub_sequence_end_index_last + 1

      sub_sequence_sum_last += array[index] 

    else
      #the single element is larger or equal to the previse sum of the sequence
      puts "----"
      sub_sequence_sum_last = array[index]
      sub_sequence_start_index_last = index
      sub_sequence_end_index_last = index
    end
    
    #compare the subsequence ending with the last elmement with the current maxium sub sequence
    if sub_sequence_sum_last > sub_sequence_sum
      #update the subseuqence 
      #puts sub_sequence_sum_last
      sub_sequence_start_index = sub_sequence_start_index_last
      sub_sequence_end_index = sub_sequence_end_index_last
      sub_sequence_sum = sub_sequence_sum_last
    elsif  sub_sequence_sum_last == sub_sequence_sum
      #keep the shortest and earilerst one
      if (sub_sequence_end_index - sub_sequence_start_index + 1) >
          (sub_sequence_end_index_last - sub_sequence_start_index_last + 1)
          sub_sequence_start_index = sub_sequence_start_index_last
          sub_sequence_end_index = sub_sequence_end_index_last
      elsif (sub_sequence_end_index - sub_sequence_start_index + 1) == 
          (sub_sequence_end_index_last - sub_sequence_start_index_last + 1)
          #update only if the new sequence apperas earilers than the current maxium one
          if sub_sequence_start_index > sub_sequence_start_index_last
            sub_sequence_start_index = sub_sequence_start_index_last
            sub_sequence_end_index = sub_sequence_end_index_last
          end
      end
    
    end # end of updating the maxium sum sub sequence

    
  end
  
  
  return [sub_sequence_start_index, sub_sequence_end_index, sub_sequence_sum]
end



if $0 == __FILE__
  # a=[1,2,3,1,4,5,6,7,0,10,12,13,]
  # p a
  # p find_longest_continuous_increasing_subsequence(a)

 #b = [1, 2, -3,5, 2,1,1, -10, -9, 5, 1,1,1,1]
  #b = [-10, -2, 99,-3, 3,3, -200, 1,0,-1,0,99,1,1,1]
  b= [ 1,2,3,4,5,6,7]
  p b 
  p fine_continue_subsequence_with_maxium_sum(b)
end
