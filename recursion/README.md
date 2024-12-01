# The Odin Project - Recursion

The process in which a *function calls itself directly or indirectly* is called **recursion** and the corresponding function is called a **recursive function**.

A recursive function solves a particular problem by calling itself with different parameters to solve smaller *sub problems* of the original problem.

The called function may further call itself and this process *might continue forever*.
So it is essential to know that we should provide a certain case in order to *terminate* this recursion process.

## Fibonacci Sequence

The **Fibonacci Sequence**, is a numerical sequence where each number is the *sum of the two numbers before it*.
The sequence begins with **0** and **1**, where the following sequences are computed by *(2 - 1) + (2 - 2), ....., (N - 1) + (N - 2)* positions.

For example -> 0, 1, 1, 2, 3, 5, 8, 13 are the first eight digits in the sequence.

## Merge Sort

**Merge Sort** is a sorting algorithm that follows the **divide-and-conquer** approach.
It works by recursively dividing the input array into smaller sub arrays and *sorting those sub arrays* then *merging* them back together to obtain the sorted array.

In simple terms, we can say that the process of merge sort is to divide the array into two halves, sort each half, and then merge the sorted halves back together.
This process is repeated until the entire array is sorted.
