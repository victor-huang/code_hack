
def process_file(file_path, batch_length)
  file_pt = open(file_path)
  
 
  dna_code_hash = {
    "00" => "A",
    "01" => "C",
    "10" => "G",
    "11" => "T",
  }
  piece_index = 1
  count = 0
  dna_set = ""
  quality_score_set = ""
  fix_bin = 0b1100_0000
  file_pt.each_byte do |byte|
    dna_code = dna_code_hash[byte[byte.size-1].to_s + byte[byte.size-2].to_s]
    dna_set += dna_code
    
    tmp_int= ((byte ^ fix_bin).to_i + 33)
    #puts tmp_int.to_i
    quality_score = "".concat(tmp_int)
    quality_score_set += quality_score
    
    count += 1
    
    if count % batch_length == 0 #print out the record set
      puts "@READ_#{piece_index}"
      puts dna_set
      puts "+READ_#{piece_index}"
      puts quality_score_set
      
      dna_set = ""
      quality_score_set = ""
      piece_index +=1
    end
    
  end

      

end



if $0 == __FILE__

  process_file("input",2)
end