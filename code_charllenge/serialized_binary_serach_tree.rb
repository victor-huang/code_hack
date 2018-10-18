require 'binarytree'

class Serilized_Node
  attr_accessor :value, :left_child_index, :right_child_index, :node
  def initialize(value=nil, left_child_index=nil, right_child_index=nil)
    @node = nil
    @value = value
    @left_child_index = left_child_index
    @right_child_index = right_child_index
  end
  
end

def deserialize_binary_search_tree(tree_nodes_array)

  new_tree = BinaryTree.new()
  
  #created all the nodes , maybe order is different
  tree_nodes_array.each do |serilized_node|
    new_tree.add(serilized_node.value)
    new_tree_node = new_tree.search(serilized_node.value)
    serilized_node.node = new_tree_node
  end
  
  #re-arrange the parent child ording
  tree_nodes_array.each do |serilized_node|
    if  serilized_node.left_child_index
      serilized_node.node.left = tree_nodes_array[serilized_node.left_child_index].node
    else
      serilized_node.node.left = nil
    end
    if serilized_node.right_child_index
      serilized_node.node.right = tree_nodes_array[serilized_node.right_child_index].node
    else
      serilized_node.node.right = nil
    end
  end
  
  return new_tree
end

def serialize_binary_search_tree( node )
  
  binary_tree_node_array = []
  
  serialize_binary_search_tree_helper(node, binary_tree_node_array)
  
  return binary_tree_node_array
end

#do in pre-order tarversing of the tree
def serialize_binary_search_tree_helper( node, nodes_array)
  
  if node.nil?
    return nil
  end
  
  s_node = Serilized_Node.new(node.value)
  
  nodes_array.push(s_node)
  node_index = nodes_array.size - 1 #the index of the sub tree root
  s_node.left_child_index = serialize_binary_search_tree_helper(node.left, nodes_array)
  s_node.right_child_index = serialize_binary_search_tree_helper(node.right, nodes_array)

  
  return node_index
end


if $0 == __FILE__

  #go here to check your tree http://binarytree.heroku.com/
  new_tree = BinaryTree.new()

  10.times do 
    node = rand(100)
    #add if it can not be find
    while new_tree.search(node)
      node = rand(100) 
    end
    p node
    new_tree.add(node)
  end

  #print the tree is sorted left to right order
  s_tree =  serialize_binary_search_tree(new_tree.root)
  sss =  Marshal.dump(new_tree)
  q_tree = Marshal.load(sss)

  open("/tmp/s_array", "w") do |file|
    file.write Marshal.dump(s_tree)
  end
  p "size " + s_tree.size.to_s
  p new_tree.to_s_pre_order()
  
  s_tree = open("/tmp/s_array", "r") do |file|
    Marshal.load(file.read)
  end
  re_constructed_tree = deserialize_binary_search_tree(s_tree)
  p re_constructed_tree.to_s_pre_order()
  p new_tree == re_constructed_tree
end