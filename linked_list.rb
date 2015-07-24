class LinkedList
  attr_accessor :current_node,
                :head,
                :count,
                :tracking_node

  def initialize(data = nil)
    if data
      @head = Node.new(data)
      @current_node = @head
      @count = 1
    else
      @head = nil
      @current_node = @head
      @count = 0
    end
  end

  def tail
    current_node
  end

  def append(data)
    if head == nil
      self.head = Node.new(data)
      self.current_node = head
    else
      self.current_node.next_node = Node.new(data)
      self.current_node = current_node.next_node
    end
    increment_count
  end

  def prepend(data)
    self.head = Node.new(data, head)
    increment_count
  end

  def count
    @count
  end

  def insert(index, data, tracking_node = nil)
    current_index = 0
    self.tracking_node = head if tracking_node == nil
    until current_index == index
      node_before = self.tracking_node
      node_after = self.tracking_node.next_node
      increment_tracking_node
      current_index += 1
    end
    node_before.next_node = Node.new(data, node_after)
    increment_count
  end

  def pop
    self.tracking_node = head
    until tracking_node.next_node == tail
      increment_tracking_node
    end
    popped_node = tail
    tracking_node.next_node = nil
    decrement_count
    popped_node
  end

  def find_by_value(data_value)
    tracking_node = head
    until tracking_node.data == data_value
      tracking_node = tracking_node.next_node
    end
    tracking_node
  end

  def remove_by_value(data_value)
    self.tracking_node = head
    until tracking_node.data == data_value
      node_before = tracking_node
      increment_tracking_node
      node_after = tracking_node.next_node
    end
    node_before.next_node = node_after
    decrement_count
    return nil
  end

  def include?(data_value)
    self.tracking_node = head
    found = false
    for number in 0..(self.count - 1)
      if tracking_node.data == data_value
        found = true
      else
        increment_tracking_node
      end
    end
    found
  end

  def draw_list
    drawing = "head"
    self.tracking_node = head
    until tracking_node.next_node == nil
      increment_tracking_node
      drawing += " -> #{tracking_node.data}"
    end
    drawing
  end

  private

  def increment_count
    self.count += 1
  end

  def decrement_count
    self.count -= 1
  end

  def increment_tracking_node
    self.tracking_node = tracking_node.next_node
  end
end

class Node
  attr_reader :data
  attr_accessor :next_node

  def initialize(data = nil, next_node = nil)
    @data = data
    @next_node = next_node
  end
end
