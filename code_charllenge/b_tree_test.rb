require 'binarytree'
require "binarytreedrawer"
require 'thread'

class NBST < BinaryTree

  def breadth_first_traversal()
    node_queue = Queue.new()
    node_queue.push(@root)
    
    while !node_queue.empty?
      node = node_queue.pop()
      print "#{node.value.to_s }, "
      if node.left
        node_queue.push(node.left)
      end
      if node.right
        node_queue.push(node.right)
      end
    end
  end
  
  def depth_first_traversal()
    depth_first_traversal_recursion(@root)
 
  end
  
  def depth_first_traversal_recursion(node)
    
    if node.nil?
      return
    else
       print "#{node.value.to_s }, "
    end
    
    depth_first_traversal_recursion(node.left)
    depth_first_traversal_recursion(node.right)
    
   
    
  end

end

if $0 == __FILE__

  new_tree = NBST.new()

  10.times do 
    node = rand(100)
    p node
    new_tree.add(node)
  end
  puts "BSF:"
  new_tree.breadth_first_traversal()
  puts 
  puts "DSF:"
  new_tree.depth_first_traversal()
  puts
  puts "in order traversal:"
  puts new_tree.to_s()
end