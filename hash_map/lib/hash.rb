# frozen_string_literal: true

# This Class creates hash from the passed in string as an argument.
class Hash
  private

  PRIME_NUMBER = 31
  attr_accessor :key

  def initialize(key)
    self.key = key
  end

  public

  def generate
    hash_code = 0
    key.each_char { |char| hash_code = PRIME_NUMBER * hash_code + char.ord }
    hash_code
  end
end
