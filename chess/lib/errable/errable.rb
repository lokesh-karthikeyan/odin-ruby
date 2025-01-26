# frozen_string_literal: true

# Exception Handling -> Custom error messages
module Errable
  # When the input is invalid.
  class InvalidSelectionError < StandardError
    def message = "Invalid Selection! Enter a valid selection.\n"
  end

  # When illegal characters were entered.
  class IllegalCharacterError < StandardError
    def message = "Illegal character(s) found! Enter only alphanumeric characters [a-z],[A-Z],[0-9].\n"
  end

  # When invalid spots were entered.
  class InvalidSpotError < StandardError
    def message = "Invalid spot is entered! Enter a valid co-ordinates for the spot.\n"
  end

  # When an enemy piece's location is entered.
  class EnemyPieceError < StandardError
    def message = "You've entered an enemy spot! Enter your piece's spot name.\n"
  end

  # When an illegal move is entered.
  class IllegalMoveError < StandardError
    def message = "Illegal move detected! Make a legal move.\n"
  end
end
