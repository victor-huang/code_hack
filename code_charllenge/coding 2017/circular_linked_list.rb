require 'ostruct'
require 'pry'

class Node < OpenStruct
  # attr_accessor :data, :next
end


def a_circular_linked_list?(head)
  slow_pointer = head
  fast_pointer = head.next

  while slow_pointer && fast_pointer
    return true if slow_pointer == fast_pointer && fast_pointer

    slow_pointer = slow_pointer.next
    # going in 2x of the speed
    return false if fast_pointer.next.nil?
    fast_pointer = fast_pointer.next.next
  end

  false
end

def follow_next(node)
  current = node
  count = 1
  max_iteration = 20

  while current
    print "#{current.data}:#{current.object_id} ->"
    current = current.next

    print "nil" unless current
    count += 1

    break if count > max_iteration
  end

  puts
end


def test
  head = nil
  previouse_node = nil
  node_array = []

  (1..10).each do |i|
    node = Node.new(data: i, next: nil)
    node_array << node
    head ||= node

    if previouse_node
      previouse_node.next = node
    end

    previouse_node = node
  end

  # create a circle
  previouse_node.next = previouse_node
  # previouse_node.next = node_array[8]

  follow_next(head)

  puts a_circular_linked_list?(head)
end

test()
