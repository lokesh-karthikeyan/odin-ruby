# The Odin Project - Linked Lists

A **linked list** is a linear collection of data elements called *nodes* that “point” to the next node by means of a pointer.

Each node holds a single element of data and a link or pointer to the next node in the list.

A *head node* is the first node in the list, a *tail node* is the last node in the list. Below is a basic representation of a linked list:

**`[ NODE(head) ] -> [ NODE ] -> [ NODE(tail) ] -> nil`**

The principal benefit of a linked list over a conventional array is that the list elements can easily be *inserted* or *removed without reallocation* of any other elements.

## Usage

Below are the *operations* that can be performed on **Linked List**.

|  **S.NO**  |         **METHODS**        |                                     **DESCRIPTION**                                      |
| ---------- | -------------------------- | ---------------------------------------------------------------------------------------- |
| 1          | `#append(value)`           | Adds a new node containing **value** to the *end* of the list.                           |
| 2          | `#prepend(value)`          | Adds a new node containing **value** to the *start* of the list.                         |
| 3          | `#size`                    | Returns the *total number of nodes* in the list.                                         |
| 4          | `#head`                    | Returns the *first node* in the list.                                                    |
| 5          | `#tail`                    | Returns the *last node* in the list.                                                     |
| 6          | `#at(index)`               | Returns the *node* at the given **index**.                                               |
| 7          | `#pop`                     | Removes the *last element* from the list.                                                |
| 8          | `#contains?(value)`        | Returns *true* if the passed in **value** is in the list and otherwise returns *false*.  |
| 9          | `#find(value)`             | Returns the *index* of the node containing **value**, or *nil* if not found.             |
| 10         | `#insert_at(value, index)` | *Inserts* a new node with the provided **value** at the given **index**. Returns *self*. |
| 11         | `#remove_at(index)`        | *Removes* the node at the given **index**. Returns the *removed node*.                   |
| 12         | `#to_s`                    | Represents the **Linked List** objects as strings in a *printable format*.               |
