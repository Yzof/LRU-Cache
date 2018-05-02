class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    total = 0
    self.each_with_index do |num, idx|
      if num.class == Array
        total += num.hash
        next
      end
      total += (idx + 1) * num
    end
    total.hash
  end
end

class String
  def hash
    arr = []

    self.each_byte do |num|
      if num === 0
        next
      end
      arr.push(num)
    end

    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    keys = self.keys.sort
    keys = keys.each_with_index do |sym, idx|
      hash = sym.to_s.hash
      keys[idx] = hash
    end
    keys.hash
  end
end
