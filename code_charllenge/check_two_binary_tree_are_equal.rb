require 'binarytree'
class NewBTree < BinaryTree

  def ==(other_tree)
      puts "---"
    return equalify_of_two_trees(@root, other_tree.root)
  end
  
  def equalify_of_two_trees(tree_root1, tree_root2)
  
    if tree_root1.nil? and tree_root2.nil?
      return true
    elsif tree_root1.nil? or tree_root2.nil?
      return false
    end
    
    is_left_child_equal = equalify_of_two_trees(tree_root1.left, tree_root2.left)
    
    
    if tree_root1 == tree_root2
      is_root_equal = true
    else
      is_root_equal = false
    end

    is_right_child_equal = equalify_of_two_trees(tree_root1.right, tree_root2.right)
    puts "#{is_left_child_equal} #{is_root_equal} #{is_right_child_equal} #{tree_root1.value.to_s}"
    return (is_left_child_equal and is_root_equal and is_right_child_equal)
  end

end


if $0 == __FILE__

 #go here to check your tree http://binarytree.heroku.com/
  #new_tree = NewBTree.new()
  new_tree = BinaryTree.new()
  tree2 = BinaryTree.new()
  5.times do 
    node = rand(100)
    p node
    new_tree.add(node)
    tree2.add(node)
  end
  new_tree.add(9)
  p new_tree == tree2


end