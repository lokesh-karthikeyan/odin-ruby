# frozen_string_literal: true

# Stores the board state, to look for "Threefold Repetition".
class GameRecords
  attr_accessor :logs, :last_state

  def log_board(board_state)
    self.last_state = board_state
    key_for_logs = board_state[0..-5]
    logs[key_for_logs] += 1
  end

  private

  def initialize
    self.last_state = ''
    self.logs = Hash.new(0)
  end
end
