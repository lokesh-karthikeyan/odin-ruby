# frozen_string_literal: true

require_relative 'colored_text'

# This Class contains methods to ask Feedback from the user inside the terminal.
class EnquireFeedback
  private

  using ColoredText

  def initialize
    @properly_placed_pegs = ''
    @misplaced_pegs = ''
  end

  def pegs_count(position, color)
    print "Enter the number of #{position} pegs: ".color_it(color)
    count = gets.chomp
    return to_valid_format(count) if valid_pegs_count?(count)

    invalid_input
    pegs_count(position, color)
  end

  def valid_pegs_count?(count)
    %w[0 1 2 3 4].include?(count)
  end

  def to_valid_format(number_in_string)
    number_in_string.to_i
  end

  def valid_total_pegs?
    @properly_placed_pegs + @misplaced_pegs < 5
  end

  def invalid_input
    puts 'Invalid input! Please enter the valid input.'.color_it('red')
    puts ''
  end

  def invalid_total_pegs
    puts 'ERR! The properly placed pegs + misplaced pegs count is higher than 4.'.color_it('red')
    puts 'Please enter appropriate values.'.color_it('red')
    puts ''
  end

  public

  def enquire_pegs_count
    @properly_placed_pegs = pegs_count('properly placed', 'green')
    @misplaced_pegs = pegs_count('misplaced', 'yellow')
    unless valid_total_pegs?
      invalid_total_pegs
      enquire_pegs_count
    end
    puts ''
    [@properly_placed_pegs, @misplaced_pegs]
  end
end
