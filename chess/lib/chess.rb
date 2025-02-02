# frozen_string_literal: true

require_relative 'load_game'
require_relative 'game_factory'

require_relative 'reportable/reportable'
require_relative 'promptable/resume_game_prompt'
require_relative 'promptable/play_again_prompt'

# Controls the entire flow of the application from intro -> outro.
class Chess
  include Reportable

  def start_game
    loop do
      deliver_introduction
      determine_game_type
      game_instance = load_game
      game_instance.play

      break if end_game?
    end
  end

  private

  attr_accessor :board_klass, :renderer, :game_type, :game_records,
                :player1, :player2,
                :board_state, :move_state, :game_state

  def deliver_introduction
    self.board_klass = GameFactory.generate_board
    print_game_title
    initial_board_setup
    self.renderer = GameFactory.create_renderer(board_state)
    display_board
    print_game_rules
  end

  def determine_game_type
    unless saved_game_exist?
      self.game_type = :new
      return
    end

    user_feedback = Promptable::ResumeGamePrompt.feedback
    self.game_type = user_feedback.eql?('y') ? :resume : :new
  end

  def load_game
    resume_game if game_type.eql?(:resume)
    new_game if game_type.eql?(:new)
    game_arguments = fetch_game_data

    GameFactory.create_game_instance(game_arguments)
  end

  def end_game? = Promptable::PlayAgainPrompt.feedback == 'n'

  def initial_board_setup = (self.board_state, self.move_state = LoadGame.initiate_board_setup(board_klass))

  def display_board = renderer.board_renderer(clear_screen: false)

  def saved_game_exist? = File.exist?('data/game_data.yml') && !File.empty?('data/game_data.yml')

  def resume_game
    self.player1, self.player2, self.game_records, self.game_state, fen_string = LoadGame.resume_game
    self.board_state, self.move_state = LoadGame.resume_prior_board_state(board_klass, fen_string)
  end

  def new_game
    self.player1, self.player2, self.game_records, self.game_state = LoadGame.new_game
  end

  def fetch_game_data
    {
      board_klass: board_klass, move_state: move_state, game_state: game_state, renderer: renderer,
      player1: player1, player2: player2, board_state: board_state, game_records: game_records, game_type: game_type
    }
  end
end

Chess.new.start_game
