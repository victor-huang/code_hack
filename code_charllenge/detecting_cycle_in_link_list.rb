require 'link_list'
#use Rabbite and Torteris algorithm ,
def is_cycle_exists(list)
  count = 0
  if !list.head or !list.head.next or !list.head.next.next
    return false #empty list has no cycle
  end
  slower_pointer = list.head
  fast_pointer = slower_pointer.next.next
  
  while fast_pointer.next and fast_pointer.next.next and fast_pointer != slower_pointer
    slower_pointer = slower_pointer.next
    fast_pointer = fast_pointer.next.next
    count += 1
  end
  
  puts "Cycle node is at #{fast_pointer.data} " if fast_pointer == slower_pointer
  puts "tarvered #{count} # of node"
  return fast_pointer == slower_pointer
end

if $0 == __FILE__
  include LinkListLib
  new_list = LinkList.new()
  10.times do |i| 
    val = rand(100)
    p i + 1
    new_list.add( i + 1 )
  end
  loop_node = new_list.create_random_cycle()
  
  p is_cycle_exists(new_list)
  #p loop_node.data
end