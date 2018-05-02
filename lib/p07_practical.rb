require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  str_arr = string.split("")
  mid = string.length / 2
  left, right = [], []

  if mid.odd?
    str_arr.slice!(mid, 1)
  end

  left = str_arr.drop(mid).sort
  right = str_arr.take(mid).sort

  left.each_with_index do |char, idx|
    if char != right[idx]
      return false
    end
  end

  true
end
