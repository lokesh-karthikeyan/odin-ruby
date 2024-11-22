# frozen_string_literal: true

require_relative '../colorable/colorable'

# This Class asks the player to make a guess & keeps track of all the guesses made so far.
class Guess
  using Colorable

  @logs = nil

  class << self
    attr_accessor :logs

    def current_guess
      new.choice
    end
  end

  private

  def initialize
    @choice = enquire_guess
    self.class.logs << choice unless choice.eql?('save')
  end

  def enquire_guess
    print "\nEnter your choice (a-z) | (save): ".color(:cyan)
    choice = gets.chomp.downcase
    validate_choice(choice)
  end

  def validate_choice(choice)
    choice = print_invalid_choice until alphabet?(choice) && valid_alphabet?(choice)
    choice = print_choice_exist(choice) until valid_choice?(choice)
    choice
  end

  def print_invalid_choice
    puts ''
    puts 'Invalid choice. Enter a SINGLE alphabet character (or) type "save".'.color(:red)
    enquire_guess
  end

  def alphabet?(choice)
    !choice.match?(/[^A-Za-z]/)
  end

  def valid_alphabet?(choice)
    choice.downcase == 'save' || choice.length == 1
  end

  def print_choice_exist(character)
    puts ''
    print "The entered character #{character.color(:green)}".color(:red)
    puts ' has already entered. Please choose another one.'.color(:red)
    enquire_guess
  end

  def valid_choice?(choice)
    !self.class.logs.include?(choice)
  end

  public

  attr_reader :choice
end
