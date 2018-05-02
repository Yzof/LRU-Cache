require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      node = @map[key]
      update_node!(node)
      node
    else
      val = calc!(key)
      if count > @max
        eject!
      end
      val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    node = @store.append(key, val)
    @map[key] = node
    val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove

    tail = @store.tail
    old_last = tail.prev

    tail.prev = node
    node.next = tail
    node.prev = old_last
    old_last.next = node

    # head = @store.head
    # old_first = head.next
    #
    # head.next = node
    # node.prev = head
    # node.next = old_first
    # old_first.prev = node
  end

  def eject!
    target = @store.first
    @store.remove(target.key)
    @map.delete(target.key)
  end
end
