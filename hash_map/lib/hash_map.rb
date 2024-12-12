# frozen_string_literal: true

require_relative 'hash_code'
require_relative 'buckets'
require_relative 'linked_list/linked_list'

# This Class creates an instance of 'Hash Map' data structure and performs hash operations.
class HashMap
  private

  attr_accessor :hash_code, :bucket_stash, :bucket, :list
  attr_reader :load_factor

  def initialize(hash_code = HashCode.new, bucket_stash = Buckets.new, list = LinkedList.new)
    self.hash_code = hash_code
    self.bucket_stash = bucket_stash
    self.bucket = bucket_stash.store
    self.list = list
    self.load_factor = 0.75
  end
end

my_hash = HashMap.new
