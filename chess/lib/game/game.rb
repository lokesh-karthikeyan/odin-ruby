# frozen_string_literal: true

require_relative '../inspect/inspector'
require_relative '../state/refresher'
require_relative '../fen/fen'
require_relative '../movements/movements'
require_relative '../movements/movement_factory'
require_relative '../reportable/reportable'

require_relative './helpers/special_move_handler'
require_relative './helpers/enquire_source'
require_relative './helpers/enquire_target'
require_relative './helpers/verifiable'
require_relative './helpers/game_over'
require_relative './helpers/update_state'

# Handles the game play from round start to round end.
class Game # rubocop:disable Metrics/ClassLength
  include Movable
  include Reportable
  include Verifiable

  def play # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    until game_over?
      display_board(default: true)
      enquire_source_piece
      return end_game(source) if end_game?(source)

      enquire_target_spot
      return end_game(target) if end_game?(target)

      move_piece
      switch_players
      update_states
      log_states
    end
    game_completed
  end

  private

  attr_accessor :board_klass, :board_state, :renderer, :move_state, :game_state,
                :player1, :player2, :active_player, :inactive_player, :game_records,
                :fifty_move_rule, :three_fold_repetition, :inspector, :refresher,
                :movable_spots, :source, :target, :last_move, :prior_piece_movement, :game_type

  def initialize(arguments) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    self.board_klass = arguments[:board_klass]
    self.renderer = arguments[:renderer]
    self.player1 = arguments[:player1]
    self.player2 = arguments[:player2]
    self.board_state = arguments[:board_state]
    self.move_state = arguments[:move_state]
    self.game_state = arguments[:game_state]
    self.game_records = arguments[:game_records]
    self.active_player = move_state.active_color.eql?(:white) ? player1 : player2
    self.inactive_player = move_state.active_color.eql?(:white) ? player2 : player1
    self.game_type = arguments[:game_type]
    self.inspector = Inspector.new(board_state, move_state)
    self.refresher = Refresher.new(move_state, game_state)
    self.fifty_move_rule = false
    self.three_fold_repetition = false
    self.source = []
    self.movable_spots = []
  end

  def game_over? = mate? || stale_mate? || fifty_move_rule || three_fold_repetition

  def display_board(default: false, source: false, target: false)
    renderer.board_renderer(self.source, clear_screen: true) if default
    renderer.board_renderer(self.source, movable_spots) if source
    renderer.board_renderer(self.target) if target
  end

  def enquire_source_piece
    print_check_message if check?
    self.source = EnquireSource.feedback(active_player, inactive_player, move_state, board_state)
    return if quit?(source) || save?(source)

    self.movable_spots = find_movable_spots(source)
    display_board(source: true)
  end

  def enquire_target_spot
    print_check_message if check?
    self.target = EnquireTarget.feedback(active_player, movable_spots)
    return if quit?(target) || save?(target)

    self.movable_spots = []
    display_board(target: true)
  end

  def move_piece
    self.prior_piece_movement = fetch_former_pieces
    board_klass.update_pieces(source, target)
    display_board(target: true)
    handle_special_moves
  end

  def switch_players
    self.active_player, self.inactive_player = inactive_player, active_player
    UpdateState.active_color(refresher)
  end

  def update_states # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    UpdateState.castling(inspector, refresher, source, target, inactive_player)
    UpdateState.en_passant_target(inspector, refresher, source, target)
    UpdateState.half_move_clock(inspector, refresher, prior_piece_movement)
    UpdateState.full_move_number(refresher, active_player)
    UpdateState.check(inspector, refresher, board_state, active_player)
    UpdateState.mate(inspector, refresher, game_state, find_movable_pieces)
    UpdateState.stale_mate(inspector, refresher, game_state, find_movable_pieces)
    self.three_fold_repetition = true if inspector.three_fold_repetition?(game_records.logs)
    self.fifty_move_rule = true if inspector.fifty_move_rule?
    self.last_move = [source, target]
    self.source = target
  end

  def log_states
    fen_string = FEN.generate(board_state, move_state)
    game_records.log_board(fen_string)
  end

  def end_game?(feedback) = quit?(feedback) || save?(feedback)

  def end_game(feedback)
    GameOver::EndGame.save(game_records, player1, player2, game_state) if feedback.eql?('s')
    GameOver::EndGame.resign(active_player, inactive_player, game_type) if feedback.eql?('q')
  end

  def game_completed
    GameOver::GameCompleted.end_round(inactive_player, three_fold_repetition, fifty_move_rule, game_state, game_type)
  end

  def handle_special_moves
    arguments = { board_klass: board_klass, renderer: renderer, active_player: active_player, move_state: move_state,
                  inspector: inspector, source: source, target: target, last_move: last_move }
    SpecialMoveHandler.new(arguments).handle
  end

  def find_movable_spots(source) = MovementFactory.moves(board_state, source, move_state)

  def find_movable_pieces = Movements.new(board_state, move_state).legal_moves

  def fetch_former_pieces
    source_piece = board_state.dig(source.first, source.last).piece.type
    target_piece = board_state.dig(target.first, target.last).piece.type
    [source_piece, target_piece]
  end
end
