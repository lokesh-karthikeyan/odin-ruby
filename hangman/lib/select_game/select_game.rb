# frozen_string_literal: true

require_relative 'game'
require_relative '../colorable/colorable'

# This Class checks if there are any saved games, if so it asks whether it can be loaded.
class SelectGame
  private

  attr_accessor :selected_game

  using Colorable

  def initialize
    saved_game_exist? ? choose_which_game : create_game
  end

  def saved_game_exist?
    File.exist?('game_data/resume_game.json') && !File.empty?('game_data/resume_game.json')
  end

  def choose_which_game
    puts ''
    puts "You've a saved game. Would you like to load that game?".color(:cyan)
    print "Press 'Y' to #{'Continue'.color(:red)}".color(:cyan)
    print " the game (or) 'N' to start a #{'New Game'.color(:red)}".color(:cyan) + ': '.color(:cyan)
    ask_player_input
  end

  def ask_player_input
    choice = gets.chomp.downcase
    choice = print_invalid_choice until %w[y n].include?(choice)
    create_game(choice)
  end

  def print_invalid_choice
    puts ''
    print 'Invalid selection. Enter your choice (y/n): '.color(:red)
    ask_player_input
  end

  def create_game(choice = 'n')
    @selected_game = choice.eql?('y') ? ResumeGame.new : NewGame.new

    @load_game = {
      secret_code: selected_game.secret_word,
      score_board: selected_game.score_board,
      lives: selected_game.lives,
      type: selected_game.type,
      guess: selected_game.guess
    }
  end

  public

  attr_reader :load_game
end
