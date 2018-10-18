
require 'yaml'

def radmon_print(file_path, line_number)

  file_ptr = open(file_path)
  
  if !File.exist? "index"
    #build he line array index
    line_array = []
    pos = 0
    line_num = 0 
    file_ptr.each_line do |line|
      
      line_array[line_num] = pos 
      p line
      pos += line.bytesize
      line_num +=1
    end
  else
    line_array = YAML::load_file("index")
  end
  
  if File.exist? "index"
    file = open("index")
    file.write line_array.to_yaml
  end
 
  file_ptr.seek(line_array[line_number], IO::SEEK_SET )
  
  line = file_ptr.readline
  puts line_number
  puts line 
end



if $0 == __FILE__
 
  radmon_print("list", 4)
  
end