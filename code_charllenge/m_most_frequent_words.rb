

def find_m_most_frequent_words(str, m)

  dictionary = {}
  #dictionary[nil] = -1

  m_order_list = [] #cheated as a linked list
  word = ""
  start_cnt = false
  str += " " #make the loop cleaner
  
  str.each_char do |char|
    if char != " " and start_cnt
      #start constructing the words
      word += char
    elsif char != " " and !start_cnt
      #initial start
      start_cnt = true
      word += char
    elsif (char == " " and start_cnt)
      #the end of the word reasched
      #do something with the words
      if dictionary.has_key? word
        dictionary[ word ] += 1
        #cuz the order in the m_order_list is change, need to delete the element and re-insert
        m_order_list.delete(word)
      else
        dictionary[ word ] = 1
      end
      
      if m_order_list.size == 0
        end_index = 0
      else
        end_index  = (m_order_list.size() - 1)
      end
      
      insert_into_sorted_array(m_order_list, dictionary, word, 0, end_index)
      m_order_list.delete_at(0) if m_order_list.size > m
      
      word = ""
      start_cnt = false #restrat a new words
    end
  
    
  end

  p dictionary.sort_by { |k,v| v}
  p dictionary.size
  p m_order_list
  p m_order_list.size
  return m_order_list[0]

end

def insert_into_sorted_array(array, dictionary, elm, start_index, end_index)


  #    if elm == "returns"
  #p array
  #puts "#{start_index.to_s} #{end_index.to_s} elm : #{elm}-#{dictionary[elm]} array size #{array.size}"
  #end
  
  #empty array case
  if array.empty?
    array.push(elm)
    return
  end
  
  #one element case
  if start_index == end_index
    if dictionary[array[start_index]] <= dictionary[elm] 
      array.insert(start_index + 1, elm)
    else
       array.insert(start_index, elm)
    end

    return
  end
  
  middle_index =  (( start_index + end_index )/2).floor
  
  if dictionary[array[middle_index]] == dictionary[elm]
    array.insert(middle_index, elm)
  elsif dictionary[array[middle_index]] > dictionary[elm] #go left
    if start_index != middle_index
      insert_into_sorted_array(array, dictionary, elm, start_index, middle_index - 1 )
    else
      insert_into_sorted_array(array, dictionary, elm, start_index, middle_index  )
    end
  elsif #go right

      insert_into_sorted_array(array, dictionary, elm, middle_index + 1 , end_index)

  end
  

end

if $0 == __FILE__
  word = " a  b b c c c e e e e e e d d d d"
  mw ="Tries to return the element at position index. If the index lies outside the array, the first form throws an IndexError exception, the second form returns default, and the third form returns the value of invoking the block, passing in the index. Negative values of index count from the end of the array."
  mw.gsub!(/,\./,"")
  p word 
  p find_m_most_frequent_words(mw, mw.size) 

end