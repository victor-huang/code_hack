require 'binarytree'

def find_lowest_common_ancestor_of_BST(root, val1, val2)
  #assume val2 > val1
  if val2 <= val1
    val2, val1 = val1, val2 #sawp if it is not larer
  end
  
  cur_node = root
  while(1)
    break if !cur_node #reach the leavef, val1 and val2 doesnt' have a common ancestor
    if cur_node.value >= val2
      #the target valu should be in the left sub tree
      cur_node = cur_node.left
    elsif cur_node.value <= val1
      #the target valu should be in the right sub tree
      cur_node = cur_node.left
    else cur_node.value >= val1 and cur_node.value  <= val2
      #the cur_node is in beween val1 and val2, hence, the common ancestor
      break
    end
  end

  return cur_node
end


if $0 == __FILE__

 #go here to check your tree http://binarytree.heroku.com/

  new_tree = BinaryTree.new()
  node_array = [3, 9, 1, 2, 4, 8, 6, 2, 0, 0]
  node_array.each do |i|
    node = i # rand(10)
    p node
    #node_array.push node
    new_tree.add(node)
  end
  
  puts "==========="
  p node_array
  puts node_array[3], node_array[5]
  p find_lowest_common_ancestor_of_BST(new_tree.root, 6 ,1)

end