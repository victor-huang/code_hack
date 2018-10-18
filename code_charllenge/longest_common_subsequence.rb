

#dynamic programming to solve the the probelem
#
class Object
   def deep_copy( object )
     Marshal.load( Marshal.dump( object ) )
   end
end

#dynamic programming to solve the the probelem
def build_lcs_length_table(str1, str2)
  p str1
  p str2
  lcs_length_table = []
  directional_table = nil
  #in both of the table the the first dimansion representing str2 and the second demansion representing str1
  (0..str2.size).each do |i|
    lcs_length_table[i] = [0]
  end
  
  (0..str1.size).each do |j|
    lcs_length_table[0][j] = 0
  end
  
  directional_table = deep_copy(lcs_length_table)

  (1..str2.size).each do |j|
    (1..str1.size).each do |i|
      devired_val = [ lcs_length_table[ j - 1 ][i], lcs_length_table[ j][ i -1 ]].max
      #determind the direction of the devired_val
      if lcs_length_table[ j - 1 ][i] == devired_val #prefre go up first when the two values are the same
        devired_from = "^"
      else
        devired_from = "<"
      end
      #puts "#{""<<str2[j - 1] } #{""<<str1[i - 1]} #{j-1} #{i-1}"
      if str2[j - 1] == str1[i - 1]
        lcs_length_table[j][i] = lcs_length_table[j-1][i-1] + 1
        directional_table[j][i] = "="
      else
        lcs_length_table[j][i] = devired_val
        directional_table[j][i] = devired_from
      end
    end
  end


  lcs_length_table.each do |row|
    p row
  end

  directional_table.each do |row|
    p row
  end
  
  p get_common_sequence_from_directional_table(directional_table, str1.size, str2.size, str2)

  return lcs_length_table
end

def get_common_sequence_from_directional_table(directional_table, str1_size, str2_size, str2)
  common_str = []
  cur_dir = directional_table[str2_size ][str1_size]
  i = str1_size
  j = str2_size
  
  while j != 0 and i !=0
    if cur_dir == "<"
      cur_dir = directional_table[j][i-1]
      i -= 1
    elsif cur_dir == "^"
      cur_dir = directional_table[j-1][i]
      j -= 1
    else # cur_dir == "\"
      cur_dir = directional_table[j-1][i-1]
      common_str.insert(0, ""<<str2[j-1]) # the str2 position is 1 less than the table, so it needs -1
      i -= 1
      j -= 1
    end
  end
  
  return common_str
end

if $0 == __FILE__
   a= "BDCABA"
   b= "ABCBDAB"
   t= "abc"
   c= "bbc"
   build_lcs_length_table(a, b)
   build_lcs_length_table(t, c)
  
  
end