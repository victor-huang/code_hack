
#this method is devired from dynamic programming
def find_longest_continuous_increasing_subsequence(array)
  cont_increasing_subsequence_length = [1]
  cont_increasing_subsequence_length.fill(1, 0, array.size - 2)
  
  longest_continuous_increasing_subsequence_length = 1
  longest_continuous_increasing_subsequence_length_end_index = 0
  (1..array.size-1).each do |index|
    if array[index] >= array[index-1]
      cont_increasing_subsequence_length[index] = cont_increasing_subsequence_length[index-1] + 1
    else
      #the new sub-sequence start, check if the found one is longer than the current LCIS
      if longest_continuous_increasing_subsequence_length < 
          cont_increasing_subsequence_length[index -1 ] 
          longest_continuous_increasing_subsequence_length = 
            cont_increasing_subsequence_length[index -1 ] 
          longest_continuous_increasing_subsequence_length_end_index = index -1
      end
      cont_increasing_subsequence_length[index] = 1
      
    end
  
  end
  
  lcis_array = []
  (0..longest_continuous_increasing_subsequence_length-1).each do |index|
    lcis_array.insert(0, array[longest_continuous_increasing_subsequence_length_end_index - index])
  
  end

  return lcis_array
end

#the run time of this dynamica programming approache can take worst case  n + O(n^2),
#it can be improve by doing a binary serach to indetify which sequence to add in, the final run time can be n+ nlogn => O(nlogn)
def find_longest_increasing_subsequence(array)
  increasing_subsequence_length = [1]
  increasing_subsequence_length.fill(1, 0, array.size - 2)

  all_increasing_sequences = [[array[0]]]
 
  (1..array.size-1).each do |index|
  
    new_sequence_needed = true
    all_increasing_sequences.each do |increasing_sequence|
      if increasing_sequence[-1] <= array[index]
        new_sequence_needed = false
        increasing_sequence.push(array[index])
        #check if we need to updated the longest increasing sequence length conut

        if increasing_subsequence_length[index-1] <= increasing_sequence.size
          increasing_subsequence_length[index] = increasing_sequence.size
        else
          increasing_subsequence_length[index] = increasing_subsequence_length[index-1]
        end
        
        break #once insert, quick the loop
      end
    end
    
    #this element is smaller than all increasing sequence's largest number, a new 
    #increasing sequence is needed to track
    if new_sequence_needed
      all_increasing_sequences.push([array[index]])
      #it can't be larger thatn existing increasing sequence
      increasing_subsequence_length[index] = increasing_subsequence_length[index-1]
    end
 
  
  end #end of scnaning all the elm in array
  
  longest_increasing_sequence = nil
  all_increasing_sequences.each do |i_sequence|
    p i_sequence
    if i_sequence.size == increasing_subsequence_length[-1]
      longest_increasing_sequence = i_sequence
    end
  end

  return longest_increasing_sequence
end

if $0 == __FILE__
  # a=[1,2,3,1,4,5,6,7,0,10,12,13,]
  # p a
  # p find_longest_continuous_increasing_subsequence(a)

  b= [90, 91, 92, 50,51,52,53,0,1, 0, 2, 0, 0, 1,1,1,1,99]
  p b 
  p find_longest_increasing_subsequence(b)
end