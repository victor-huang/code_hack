require 'binarytree'
require "binarytreedrawer"

#depends on the binary search tree modlue


class BSTree < BinaryTree
  def find_the_nth_maximum(n_th)
    
    if @total_nodes < n_th
      puts "The tree has less than #{n_th} number of nodes"
      return 
    end
    @_n_th = n_th
    
    find_the_nth_maximum_recursion_helper(@root)
  
  end
  
  def find_the_nth_maximum_recursion_helper(node)
  
    if node.nil? or @_n_th <= 0
      return 
    end
    
    #traversing order will be right -> center -> left ->
    find_the_nth_maximum_recursion_helper(node.right)
    
    #process the node
    if @_n_th == 1
      puts "The maxium n_th element is #{node.value} "
    end
    @_n_th -= 1
    find_the_nth_maximum_recursion_helper(node.left)
    
    return 
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

  #go here to check your tree http://binarytree.heroku.com/
  new_tree = BSTree.new()

  10.times do 
    node = rand(100)
    p node
    new_tree.add(node)
  end

  #print the tree is sorted left to right order
  new_tree.find_the_nth_maximum(5)
  
end