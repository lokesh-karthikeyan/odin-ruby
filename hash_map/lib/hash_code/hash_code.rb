# frozen_string_literal: true

# This Class contains ways to make a 'Hash Code' from a given 'String'.
class HashCode
  class << self
    PRIME_NUMBER = 31

    def generate(key)
      hash_code = 0

      key.each_char { |char| hash_code = PRIME_NUMBER * hash_code + char.ord }

      hash_code
    end
  end
end
