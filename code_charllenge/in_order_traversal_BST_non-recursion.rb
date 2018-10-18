require 'binarytree'

def in_order_BST_traversal_non_recursion(root)
  
  node_stack = []
  right_node_stack = [root]
  while (cur_node = right_node_stack.pop)
   # p "==="
    #p cur_node.value
    #enqueue all the left tree's node like deapest first search
    node_stack.push(cur_node)
    while(cur_node.left)
      node_stack.push(cur_node.left)
      cur_node = cur_node.left
    end

    while(last_left_child = node_stack.pop)
      #do something with the current node
      print last_left_child.value.to_s + " , "
      #enqueue the right child of the last last_left_child, if there is any
      if last_left_child.right
        right_node_stack.push(last_left_child.right) 
        break
      end
    end
    
  end
  puts
end


if $0 == __FILE__

 #go here to check your tree http://binarytree.heroku.com/
  #new_tree = NewBTree.new()
  new_tree = BinaryTree.new()
  11.times do 
    node = rand(100)
    p node
    new_tree.add(node)
  end

  in_order_BST_traversal_non_recursion(new_tree.root)
  p  new_tree.to_s_pre_order()


end