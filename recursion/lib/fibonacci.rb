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
end

Fibonacci.new.fibs(8)
