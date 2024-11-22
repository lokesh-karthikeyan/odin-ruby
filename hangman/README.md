# The Odin Project - Hangman

**Hangman** is a guessing game for two or more players.
One player thinks of a *word*, *phrase*, or *sentence* and the other(s) tries to guess it by suggesting letters or numbers within a *certain number of guesses*.

## Objective

- To make the program more like an ***Object Oriented*** rather than *Function Oriented*.
- To get hands-on experience in *File Manipulation* and *File Serialization*.

## Usage

Upon loading the game, the computer will choose a *random word* within the length of **5 - 12**.

Player has to make a guess, if the guess is **correct**, then the guessed letter will be *inserted* wherever it appears.
If the guess is **incorrect**, then *lives* will be reduced & the *stick figure will be sentenced to hang*.

The object of hangman is to guess the secret word before the **stick figure is hung**.

## Demo



## Features

- As this project is to work with *File Serialization*, the game can be **saved** whenever the player types `save`.

- When the game is loaded, if there's any saved game, it will prompt the player to choose either **Continue Game** (or) **New Game**.

## Acknowledgements

[CJ Avilla's Hangman with ruby for beginners](https://www.youtube.com/watch?v=LQGRzObX94o)
