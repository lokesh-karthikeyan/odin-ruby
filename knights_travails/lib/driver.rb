# frozen_string_literal: true

require_relative './knights_travails'

shortest_path = KnightsTravails.new

puts 'When the source (or) destination exceeds the maximum range:- '
shortest_path.knight_moves([0, 0], [8, 5])

puts '---------------------------------------------'

puts 'When the source & destination are same:- '
shortest_path.knight_moves([3, 3], [3, 3])

puts '---------------------------------------------'

puts 'When the source & destination are different:- '
shortest_path.knight_moves([0, 0], [1, 2])

puts '---------------------------------------------'
shortest_path.knight_moves([0, 0], [3, 3])

puts '---------------------------------------------'
shortest_path.knight_moves([3, 3], [0, 0])

puts '---------------------------------------------'
shortest_path.knight_moves([0, 0], [7, 7])

puts '---------------------------------------------'
shortest_path.knight_moves([3, 3], [4, 3])
