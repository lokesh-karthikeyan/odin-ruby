# The Odin Project - HashMap

A **hash table** is a *data structure* that implements an *associative array*, also called a **dictionary** or simply **map**.

An associative array is an *abstract data type* that maps *keys* to *values*.
A hash table uses a hash function to compute an *index*, also called a *hash code*, into an array of *buckets* or slots, from which the desired value can be found.

During lookup, the key is hashed and the resulting hash indicates where the corresponding value is stored.
A map implemented by a hash table is called a **hash map**.

A **Set** is similar to a hash map but the key difference is that a Set will have nodes with only *keys* and *no values*.
It is called as **hash set**.

## Usage

### HashMap Operations

Below are the *operations* that can be performed on **HashMap**.

|  **S.NO**  |         **METHODS**        |                                         **DESCRIPTION**                                       |
| ---------- | -------------------------- | --------------------------------------------------------------------------------------------- |
| 1          | `#set(key, value)`         | Adds the **key**, **value** to the table, if the key doesn't exist yet.                       |
| 2          | `#get(key)`                | Returns the *value* that is assigned to this **key**. If key is not found, returns *nil*.     |
| 3          | `#has?(key)`               | Returns *true* or *false* based on whether or not the **key** is in the hash map.             |
| 4          | `#remove(key)`             | Removes the entry and returns deleted entry's *value*, if there's no key returns *nil*.       |
| 5          | `#length`                  | Returns the *total number* of stored keys in the hash map.                                    |
| 6          | `#clear`                   | *Removes all entries* in the hash map.                                                        |
| 7          | `#keys`                    | Returns an array containing all the *keys* inside the hash map.                               |
| 8          | `#values`                  | Returns an array containing all the *values* inside the hash map.                             |
| 9          | `#entries`                 | Returns an array that contains each *key, value* pairs.                                       |

### HashSet Operations

Below are the *operations* that can be performed on **HashSet**.

|  **S.NO**  |         **METHODS**        |                                         **DESCRIPTION**                                       |
| ---------- | -------------------------- | --------------------------------------------------------------------------------------------- |
| 1          | `#set(key)`                | Adds the **key** to the table, if the key doesn't exist yet.                                  |
| 2          | `#has?(key)`               | Returns *true* or *false* based on whether or not the **key** is in the hash table.           |
| 3          | `#remove(key)`             | Removes the key and returns the *deleted key*, if there's no key returns *nil*.               |
| 4          | `#length`                  | Returns the *total number* of stored keys in the hash table.                                  |
| 5          | `#clear`                   | *Removes all entries* in the hash table.                                                      |
| 6          | `#keys`                    | Returns an array containing all the *keys* inside the hash table.                             |
