# frozen_string_literal: true

require_relative 'binary_search_tree'

array = (Array.new(15) { rand(1..100) })

binary_search_tree = BinarySearchTree.new(array)

puts "Does the binary search tree balanced? --> #{binary_search_tree.balanced?}"

puts '***************************==============================**********************************'

puts 'The tree view:'
binary_search_tree.view

puts '***************************==============================**********************************'

puts "The tree structure in 'Level-Order' (Without Block) --> #{binary_search_tree.level_order}".inspect
puts "The tree structure in 'Level-Order' (With Block 'Increment by 1') --> #{binary_search_tree.level_order do |number|
  number + 1
end}".inspect

puts '***************************==============================**********************************'

puts "The tree structure in 'Pre-Order' (Without Block) --> #{binary_search_tree.preorder}".inspect
puts "The tree structure in 'Pre-Order' (With Block 'Increment by 1') --> #{binary_search_tree.preorder do |number|
  number + 1
end}".inspect

puts '***************************==============================**********************************'

puts "The tree structure in 'Post-Order' (Without Block) --> #{binary_search_tree.postorder}".inspect
puts "The tree structure in 'Post-Order' (With Block 'Increment by 1') --> #{binary_search_tree.postorder do |number|
  number + 1
end}".inspect

puts '***************************==============================**********************************'

puts "The tree structure in 'In-Order' (Without Block) --> #{binary_search_tree.inorder}".inspect
puts "The tree structure in 'In-Order' (With Block 'Increment by 1') --> #{binary_search_tree.inorder do |number|
  number + 1
end}".inspect

puts '***************************==============================**********************************'

puts "Insert number #{binary_search_tree.insert(120)}"
puts "Insert number #{binary_search_tree.insert(180)}"
puts "Insert number #{binary_search_tree.insert(1000)}"
puts "Insert number #{binary_search_tree.insert(800)}"
puts "Insert number #{binary_search_tree.insert(190)}"
puts "Insert number #{binary_search_tree.insert(155)}"
puts "Insert number #{binary_search_tree.insert(1340)}"
puts "Insert number #{binary_search_tree.insert(1670)}"
puts "Insert number #{binary_search_tree.insert(107)}"
puts "Insert number #{binary_search_tree.insert(-1)}"
puts "Insert number #{binary_search_tree.insert(-5)}"

puts '***************************==============================**********************************'

puts 'Post Insertion:'
binary_search_tree.view

puts '***************************==============================**********************************'

puts "Delete number #{binary_search_tree.delete(0)}"
puts "Delete number #{binary_search_tree.delete(-5)}"
puts "Delete number #{binary_search_tree.delete(800)}"
puts "Delete number #{binary_search_tree.delete(120)}"

puts '***************************==============================**********************************'

puts 'Post Deletion:'
binary_search_tree.view

puts '***************************==============================**********************************'

puts "Does the binary search tree balanced? --> #{binary_search_tree.balanced?}"

puts '***************************==============================**********************************'

binary_search_tree.rebalance
puts 'Tree Rebalanced:'

puts '***************************==============================**********************************'

puts "Does the binary search tree balanced? --> #{binary_search_tree.balanced?}"

puts '***************************==============================**********************************'

puts 'Post Rebalancing:'
binary_search_tree.view

puts '***************************==============================**********************************'

puts "The tree structure in 'Level-Order' (Without Block) --> #{binary_search_tree.level_order}".inspect
puts "The tree structure in 'Level-Order' (With Block 'Increment by 1') --> #{binary_search_tree.level_order do |number|
  number + 1
end}".inspect

puts '***************************==============================**********************************'

puts "The tree structure in 'Pre-Order' (Without Block) --> #{binary_search_tree.preorder}".inspect
puts "The tree structure in 'Pre-Order' (With Block 'Increment by 1') --> #{binary_search_tree.preorder do |number|
  number + 1
end}".inspect

puts '***************************==============================**********************************'

puts "The tree structure in 'Post-Order' (Without Block) --> #{binary_search_tree.postorder}".inspect
puts "The tree structure in 'Post-Order' (With Block 'Increment by 1') --> #{binary_search_tree.postorder do |number|
  number + 1
end}".inspect

puts '***************************==============================**********************************'

puts "The tree structure in 'In-Order' (Without Block) --> #{binary_search_tree.inorder}".inspect
puts "The tree structure in 'In-Order' (With Block 'Increment by 1') --> #{binary_search_tree.inorder do |number|
  number + 1
end}".inspect

puts '***************************==============================**********************************'
