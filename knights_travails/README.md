# The Odin Project - Knights Travails

A **Knight** in *chess* moves in an *L-shape*.
It can move two squares in one direction (either horizontally or vertically) and then make a 90-degree turn to move one square in a *perpendicular* direction.

Given enough turns, a knight on a standard `8 x 8` chess board can move from any square to any other square.

The *goal* is to traverse the graph (the chessboard) to find the *shortest route* between two nodes (the start and end positions).
It should also needs to output all squares the knight will stop on along the way.

For example, `knight_moves([0, 0], [7, 7])` will return as below:

**`You made it in 6 move(s)! Here's your path:`<br>`[0, 0] -> [2, 1] -> [4, 2] -> [6, 3] -> [7, 5] -> [5, 6] -> [7, 7]`**
