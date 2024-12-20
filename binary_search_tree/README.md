# The Odin Project - Binary Search Tree

A **Binary Search Tree (BST)**, also called an **Ordered** or **Sorted binary tree**, is a *rooted binary tree* data structure.

- The key of each internal node being *greater* than all the keys in the respective node's left sub tree.
- The key of each internal node being *lesser* than all the keys in the respective node's right sub tree.

The *time complexity* of operations on the binary search tree is *linear* with respect to the *height of the tree*.
Binary search trees allow binary search for fast lookup, addition, and removal of data items.

## Usage

Below are the operations that can be performed on **Binary Search Tree**.

|  **S.NO**  |         **METHODS**        |                                         **DESCRIPTION**                                             |
| ---------- | -------------------------- | --------------------------------------------------------------------------------------------------- |
| 1          | `#insert(value)`           | Adds the **value** as a *leaf node*, if the value doesn't exist.                                    |
| 2          | `#delete(value)`           | Removes the node containing the **value** from the tree. Returns *nil* if the value doesn't exist.  |
| 3          | `#find(value)`             | Returns the *value* if the given **value** exist, else returns *nil*.                               |
| 4          | `#level_order`             | Returns *array* of values if no `block_given?`. Else *yield* each value to the *block*.             |
| 5          | `#inorder`                 | Returns *array* of values if no `block_given?`. Else *yield* each value to the *block*.             |
| 6          | `#preorder`                | Returns *array* of values if no `block_given?`. Else *yield* each value to the *block*.             |
| 7          | `#postorder`               | Returns *array* of values if no `block_given?`. Else *yield* each value to the *block*.             |
| 8          | `#height(node)`            | Returns the *height* of the longest path from a given **node** to a *leaf node*.                    |
| 9          | `#depth(node)`             | Returns the *depth* of the path from a *root node* to the given **node**.                           |
| 10         | `#balanced?`               | Returns *true* if *height* of *`Left sub tree - Right sub tree = (-1..1)`*. Else *false*.           |
| 11         | `#rebalance`               | Sorts the *nodes*, and creates a new **Binary Search Tree**.                                        |
