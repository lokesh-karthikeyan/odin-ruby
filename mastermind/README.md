# The Odin Project - Mastermind

***Mastermind*** or ***Master Mind*** is a code-breaking game for two players.

It’s a game where you have to guess your opponent’s secret code within a certain *number of turns*.
Each turn you get some **feedback** about how good your guess was – whether it was *exactly correct* or just the correct color but in the *wrong space*.

## Objective

- To get hands-on experience in writing programs based on `OOP Paradigm`.
- To implement an existing `algorithm` into a code.

## Demo

The video shows the gameplay & the **rules** are explained during the game.



https://github.com/user-attachments/assets/b6a3b1b8-657d-4a40-b8cb-96d977fc2137



**Computer** will always win within **5** moves, as it follows the [Donald Knuth's "Worst case: Five-guess algorithm"](https://en.wikipedia.org/wiki/Mastermind_(board_game)#Best_strategies_with_four_holes_and_six_colors) unless the **feedbacks** are incorrectly provided.

## Challenges

1. Understanding & Implementation of **Donald Knuth's** `Worst case: Five-guess algorithm` into the code base.
2. Understanding & Implementation of `Minimax` technique.
3. Connecting all the components to make the application properly function without reducing *Code Readability* and causing *Code Smell*.

## Acknowledgements

* [Mastermind with Steve Mould's](https://www.youtube.com/watch?v=FR_71HyBytE) video explains how the game is played with Knuth's algorithm.
* [Beating Mastermind: Winning with the help of Donald Knuth by Adam Forsyth](https://www.youtube.com/watch?v=Okm_t5T1PiA&t=37s) is a **RubyConf** video explains in detail about how the algorithms & techniques can be implemented into a code base.
* [Aydin Schwartz's Solving Mastermind With Python](https://betterprogramming.pub/solving-mastermind-641411708d01) is an article that explains in detail about the working & implementation of the algorithm.
