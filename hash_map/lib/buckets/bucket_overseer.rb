# frozen_string_literal: true

# This Module keeps track of the load levels & increments the 'Buckets' if required.
module BucketOverseer
  private

  LOAD_FACTOR = 0.75

  def capacity = bucket.length

  def load_levels = LOAD_FACTOR * capacity

  def load_exceeded? = length > load_levels

  def new_hash_map(entries) = entries.each { |key, value| set(key, value) }

  def new_hash_set(keys) = keys.each { |key| set(key) }

  def increase_buckets
    entry_list = defined?(entries) ? entries : keys

    self.length = 0
    self.bucket = buckets.new(capacity * 2)

    entry_list.first.is_a?(Array) ? new_hash_map(entry_list) : new_hash_set(entry_list)
  end
end
