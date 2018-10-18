
require 'tempfile'

def disk_merge_sort_helper(supper_large_array)

  #write the array to file in disk
  file = Tempfile.new('ori_array')
  file.puts supper_large_array.join(",")
  file.rewind
  
  number = ""
  (0..file.size + 1).each do |cur_pos|
    #file.seek(cur_pos)
    char = file.readchar if !file.eof?
    #puts char , file.eof?
    if char != 44 and !file.eof?
      number << char
    else
      puts number
      number = ""
    end
  end
  
  puts number #the last number in the list
  #puts file.size
  file.rewind
  puts file.readline
  
  
  #puts file.path
  #puts File.size?(file.path)
  file.rewind
  sorted_file = disk_merge_sort(file,0)
  
  sorted_file.rewind
  line = sorted_file.readline
  supper_large_array.sort!.join(",")
  new_array = line.split(",")
  
  new_array.each_index do |index|
    if new_array[index].to_i != supper_large_array[index]
   
      puts "not match at index #{index} #{new_array[index] } != #{supper_large_array[index]}"
      break
    end
  end
  
  b= $stdin.read
  file.close
end


#file_array is the file descptor of the file contains the array of integer
  $max = 99999
  $ori = $max 
def disk_merge_sort(file_array, level)

  
  if (file_array.eof? or get_next_integer(file_array) == "" or get_next_integer(file_array) == "" )
    file_array.rewind
    return file_array
  end
  
  if $max < 0
    
    return file_array
  else
    puts "---" + ($ori - $max + 1).to_s
    $max -= 1
  end
  
  file_array.rewind
  middle_pos = (file_array.size / 2 ).floor
  left_array_file = Tempfile.new("#{level}_left_array_")
  right_array_file = Tempfile.new("#{level}_right_array_")
  
  number = ""
  (0..file_array.size + 1).each do |cur_pos|
    
    char = file_array.readchar if !file_array.eof?

    if char != 44 and !file_array.eof?
      number << char
    else
       #puts number
       #print number +","
      if number != ""
        if file_array.pos <= middle_pos or left_array_file.pos == 0 #ensure , the first elm, will go to the left, if there is less than 2 elms
          left_array_file.write(number + ",") 
        else
          right_array_file.write(number + ",") 
        end
      end
      number = ""
    end
  end
  
  left_array_file.rewind
  right_array_file.rewind
  left_sorted_array_file = disk_merge_sort(left_array_file, level + 1)
  right_sorted_array_file = disk_merge_sort(right_array_file, level + 1)
  
  # p level
  # p left_sorted_array_file.path
  # p right_sorted_array_file.path
  # puts level
   # puts left_sorted_array_file.readline
   # puts right_sorted_array_file.readline
     left_sorted_array_file.rewind
   right_sorted_array_file.rewind
  
  left_int = get_next_integer(left_sorted_array_file)
  right_int = get_next_integer(right_sorted_array_file)
  merged_array_file = Tempfile.new("merged_array_#{level}_")
  while left_int != "" and right_int != ""
    if left_int.to_i <= right_int.to_i 
      merged_array_file.write(left_int + ",")
      left_int = get_next_integer(left_sorted_array_file)
    else
      merged_array_file.write(right_int + ",")
      right_int = get_next_integer(right_sorted_array_file)
    end
  end
  
  #one of the array is end
  while left_int != "" or right_int != ""
    if left_int!= ""
      merged_array_file.write(left_int + ",")
      left_int = get_next_integer(left_sorted_array_file)
    else 
      merged_array_file.write(right_int + ",")
      right_int = get_next_integer(right_sorted_array_file)
    end
  end
  
  merged_array_file.rewind
  return merged_array_file
  
end

def get_next_integer(file)
  number = ""

    (file.pos..file.size + 1).each do |cur_pos|
      #file.seek(cur_pos)
      char = file.readchar if !file.eof?
      #puts char , file.eof?
      if char != 44 and !file.eof?
        number << char
      else
        return number
      end
    end

  
  return number
end


if $0 == __FILE__
  test = []
  9000.times do 
    test.push(rand(150))
  end

  p test
  disk_merge_sort_helper(test)
  
end