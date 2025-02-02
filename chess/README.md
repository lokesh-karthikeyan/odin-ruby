# The Odin Project - Chess

**Chess** is a *board game* for two players.
It is sometimes called **International chess** or **Western chess** to distinguish it from related games such as *xiangqi* (Chinese chess) and *shogi* (Japanese chess).

The objective of the game is to **checkmate** (threaten with inescapable capture) the enemy king. There are also several ways a game can end in a *draw*.

This is a **CLI based chess**, where you need to enter the *origin square* & *destination square* to make the move.

## Objective

This was done as part of [The Odin Project's final ruby project](https://www.theodinproject.com/lessons/ruby-ruby-final-project).

## Features

Most of the [chess rules](https://en.wikipedia.org/wiki/Rules_of_chess) has been implemented in this application.

- **Check mate** will be detected as it's a winning rule.
- *Quitting* the game will be considered as **Resigning** and the *win* goes to the other player.
- **Stale mate**, **Three-fold repetition**, **Fifty-move rule** will be detected & declare it as a *tie*.
- Movements such as **En passant**, **Castling**, **Pawn promotion** has been implemented.
- **Simple AI** that can make *move* and *capture*.
- **Save** the game & *reload* the saved game whenever you can.

## Demo



https://github.com/user-attachments/assets/60933d46-a7f8-4f47-916b-dcff52e8703e



### Stale mate

![stale_mate](https://github.com/user-attachments/assets/a41bda6c-2eb5-421b-8ebd-819900997f12)


### Three-fold repetition

![three_fold_repetition](https://github.com/user-attachments/assets/90fa0927-6105-4bf4-b2f6-1916e9e8d660)


### Fifty-move rule

![fifty_move_rule](https://github.com/user-attachments/assets/54b7958d-b4bd-45be-861c-fb9be5e48723)


### En passant

![en-passant](https://github.com/user-attachments/assets/ddfc9299-5e66-4b44-8264-08e52875ffdd)


### Pawn promotion

![pawn_promotion](https://github.com/user-attachments/assets/1aa84ddb-eef6-4e08-97f6-e28cb4698657)


### Castling

![castling](https://github.com/user-attachments/assets/eb93a442-3ab9-4b3e-911b-c5d37b5d2687)

