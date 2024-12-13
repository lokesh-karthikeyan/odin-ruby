# frozen_string_literal: true

# This Module contains the Class to generate 'Hash' & the method to compute 'Low number Index'.
module HashIndexable
  # This Class creates hash from the passed in string as an argument.
  class HashCode
    PRIME_NUMBER = 31

    def generate(key)
      hash_code = 0

      key.each_char { |char| hash_code = PRIME_NUMBER * hash_code + char.ord }
      hash_code
    end
  end

  DIVISOR = 16

  def compute_index(key) = HashCode.generate(key) % DIVISOR
end
