require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Hash.new }
    @count = 0
  end

  def insert(key)
    self[key] = key
    @count += 1
    if @count == num_buckets
      resize!
    end
  end

  def include?(key)
    self[key] ? true : false
  end

  def remove(key)
    self[key] = false
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    num = key.hash
    index = num % num_buckets
    map = @store[index]
    map[num]
  end

  def []=(key, value)
    num = key.hash
    index = num % num_buckets
    map = @store[index]
    map[num] = value
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets * 2
    new_store = Array.new(new_buckets) { Hash.new }
    
    @store.each do |bucket|
      bucket.each do |key, value|
        num = key.hash
        index = num % new_buckets
        map = new_store[index]
        map[num] = value
      end
    end

    @store = new_store
  end
end
