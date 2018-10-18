
module LinkListLib
  class ListNode
    attr_accessor :data, :next
    def initialize(data)
      @data = data
      @next = nil
    end
  end

  class LinkList
    attr_reader  :head, :tail, :size
    def initialize()
      @head = nil
      @size = 0
      @tail = nil
    end
    
    #the data to be store
    def add(data)
      new_node = ListNode.new(data)
      if @head
        @tail.next = new_node
        @tail = new_node
      else
        @head = new_node
        @tail = new_node 
      end
      
      @size += 1
    end
    
    def delete(target_node)
      prev_node = nil
      self.each do |node|
        
        if  target_node == node
          if prev_node 
            prev_node.next = node.next
          else
            #only one node in the list
            @head = nil
            @tail = nil
          end
          if node == @tail 
            @tail = prev_node
          end
          @size -= 1
          break
        end
        prev_node = node 
      end    
    end
    
    def delete_by_data(target_data)
      prev_node = nil
      self.each do |node|
        if  target_data == node.data
          if prev_node 
            prev_node.next = node.next
          else
            #only one node in the list
            @head = nil
            @tail = nil
          end
          if node == @tail 
            @tail = prev_node
          end
          @size -= 1
          break
        end
        prev_node = node 
      end    
    end
    #get the ith node in the list
    def get(ith)
      count = 1
      self.each do |node|
        if count == ith
          return node
        end
        count += 1
      end
      return nil
    end
    
    #caution!! once it is called, the list maybe go in a infinite loop
    #connect the tail with a random node in the list
    def create_random_cycle()
      nth = rand(@size) + 1
      puts "Cycle will be on the #{nth} node" if @size != 0
      loop_node = nil
      each do |node|
        if nth == 1
          loop_node = node
        end
        
        nth -= 1
      end
      @tail.next = loop_node if loop_node
      return loop_node
    end
    
    def each(&block)
      cur = @head
      while( cur )
        block.call(cur) #call the bloc with the current node
        cur = cur.next
      end
    end
    
    def pp()
      out_str = ""
      self.each do |elm|
        out_str += elm.data.to_s + "->"
      end
      puts out_str[0..out_str.size-3]
      
    end
    
  end
  
end

if $0 == __FILE__ 
   #units tests
  include LinkListLib
  new_list = LinkList.new()
  3.times do |i|
    
    val = rand(100)
    p i
    new_list.add( i )
    
  end
  new_list.pp()
  new_list.delete(new_list.get(8))
  new_list.delete_by_data(0)
  new_list.delete_by_data(1)
  new_list.delete_by_data(2)
  new_list.delete_by_data(3)
  new_list.pp()
  
end
