
#all the small string in the set has the same length which is less than the size of large_string
#approache 1 : building a lookup table for all the small string set
def find_small_set_of_string_in_large_string( large_string, small_string_set)
  
  #create and array of size L,
  small_string_size = small_string_set[0].size
  window_array = []
  
  (0..small_string_size-1).each do |index|
    window_array[index] = {}
  end
  
  #build dthe window array as we look a all the small string in a set
  small_string_set.each do |str|
    (0..str.size - 1).each do |index|
      if !window_array[index].has_key? str[index]    
        #create new hash
        window_array[index][str[index]]={}
      end
      window_array[index][str[index]][str] = str
    end
  end

  all_found = []
  (0..large_string.size - small_string_size).each do |window_start|
    found_set = []
    first_set = true
    qualified_length = 0

    (window_start..window_start + small_string_size -1 ).each do |index|
    
      #puts "String start at index #{window_start} '#{""<<large_string[window_start]}'"
      
      if window_array[ index - window_start  ].has_key? large_string[index ]
        if first_set 
          window_array[ index - window_start ][large_string[index]].each do |key, val|
            found_set.push(key)
          end
          first_set = false
        else
          window_array[ index - window_start  ][large_string[index]].each do |key, val|
            if !found_set.include? key
              found_set.delete(key)
            end
          end
        end
        qualified_length += 1 if !found_set.empty? #suvire from the delete, increase the qualified lenghth
      elsif first_set == false and found_set.empty?
        #puts "stop examing 1"
        break
      else
        #puts "stop examing 2 -- #{window_start.to_s} #{index.to_s}"
        break
      end
    end #end of exampling each slow of the window
    #only print and save qualify string
    #p qualified_length , window_array.size
    if qualified_length == window_array.size
      all_found = all_found | found_set
      
      #puts "Found:" + found_set.join(",")
    end
    
  end
  #p window_array
  return all_found
end

require 'digest/md5'

def find_small_set_of_string_in_large_string_md5_hashing( large_string, small_string_set)
    # Digest::MD5.hexdigest("d")
    md5_hash_array = []
    window_size = small_string_set[0].size
    #build the md5 hash of window start at each index
    (0..large_string.size - window_size).each do |index|
      md5_hash_array[index] = Digest::MD5.hexdigest(large_string[index..index + window_size - 1 ])
    end
    
    found_set = []
    md5_hash_array.each_index do |window_start|
      small_string_set.each do |small_str|
        str_md5 = Digest::MD5.hexdigest(small_str)
        if md5_hash_array[window_start] == str_md5
          #need to compare each one to see if the string is a exact match
          match = true
          (window_start..window_size-1).each do |index|
            if large_string[index] != small_str[index - window_start]
              match = false
              break
            end
          end #end of the colision resolution loop
          found_set = found_set | [small_str] if match
        end
        
      end

    end #end of looping all the windows of larger string

    return found_set
end

if $0 == __FILE__
  large_string = "i am the cool man in the world that's small and big and crzy"
  l_s = 'Most biological entities that are more complex than a virus sometimes or always carry additional genetic material besides that which resides in their chromosomes. In some contexts, such as sequencing the genome of a pathogenic microbe, "genome" is meant to include information stored on this auxiliary material, which is carried in plasmids. In such circumstances then, "genome" describes all of the genes and information on non-coding DNA that have the potential to be present. In eukaryotes such as plants, protozoa and animals, however, "genome" carries the typical connotation of only information on chromosomal DNA. So although these organisms contain chloroplasts and/or mitochondria that have their own DNA, the genetic information contained by DNA within these organelles is not considered part of the genome. In fact, mitochondria are sometimes said to have their own genome often referred to as the "mitochondrial genome". The DNA found within the chloroplast may be referred to as the "plastome".'
  
  str_set = [
    "DNA",
    "the",
    'man',
    'big',
    'Z-Z',
    "own",
    "are",
    "lop",
    "pop",
    "zao",
    "lco",
    "uqw"
  ]
  
  t1 = Time.now.to_f
  p find_small_set_of_string_in_large_string(l_s, str_set)
  t2 = Time.now.to_f
  puts "Time used #{t2-t1}"
  
  p
  p
  t1 = Time.now.to_f
  p find_small_set_of_string_in_large_string_md5_hashing(l_s, str_set)
  t2 = Time.now.to_f
  puts "Time used #{t2-t1}"

end