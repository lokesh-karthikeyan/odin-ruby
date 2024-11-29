# frozen_string_literal: true

# This Class generates 'Fibonacci Sequence' in an array with 'N' elements.
class Fibonacci
  def fibs(number)
    fibonacci_sequence = []
    0.upto(number) do |count|
      next fibonacci_sequence << count if count.zero? || count.eql?(1)

      break if fibonacci_sequence.length.eql?(number)

      fibonacci_sequence << (fibonacci_sequence[count - 1] + fibonacci_sequence[count - 2])
    end
    puts "The Fibonacci Sequence of #{number} numbers are => #{fibonacci_sequence}"
  end

  def fibs_rec(number, initial_value = 0, fibonacci_sequence = [])
    return if number.zero?

    statement = ->(count, fib_sequence) { puts "The Fibonacci Sequence of #{count} number(s) are => #{fib_sequence}" }
    return statement.call(number, fibonacci_sequence) if number.eql?(initial_value)

    fibonacci_sequence << initial_value if initial_value < 2
    if initial_value >= 2
      fibonacci_sequence << (fibonacci_sequence[initial_value - 1] + fibonacci_sequence[initial_value - 2])
    end

    fibs_rec(number, initial_value + 1, fibonacci_sequence)
  end
end

# Fibonacci.new.fibs(0)
Fibonacci.new.fibs_rec(8)
