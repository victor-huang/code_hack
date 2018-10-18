
#the best way to find the nth-to-last element from the link lists, giving that we don't know the end

require 'link_list'


#my first impllmentation , which is not so clean
def find_nth_to_last_element_link_list_me( nth , list)
  if nth > list.size - 1 
    return nil #invaliade range
  end
  
  m_th_to_last_node = list.head
  
  start_cnt = nth # the m_th_to_last_node pointer will start increment when this is 0 
  start_cnt += 1 if nth != 0 #adjusting the slower pointer to fix the requirement
  list.each do |node|

    if start_cnt == 0 
      if m_th_to_last_node.next #move only when the next node is not the end
        m_th_to_last_node = m_th_to_last_node.next  
      end  
    else
      start_cnt -= 1
    end
    
  end

  return m_th_to_last_node
end

#the stardard clean implementation 
def find_nth_to_last_element_link_list( nth , list)

  cur = list.head 
  (1..nth).each do |index|
    if !cur
      return nil
    end
    cur = cur.next
  end
  m_th_to_last_node = list.head
  
  while cur.next
    m_th_to_last_node = m_th_to_last_node.next
    cur = cur.next
  end

  return m_th_to_last_node
end

if $0 == __FILE__
  include LinkListLib
  new_list = LinkList.new()
  10.times do |i| 
    val = rand(100)
    p i + 1
    new_list.add( i + 1 )
  end
  new_list.pp
  10.times do |i|
    p find_nth_to_last_element_link_list_me(i, new_list).data
    p find_nth_to_last_element_link_list(i, new_list).data
  end
end