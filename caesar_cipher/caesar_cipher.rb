# frozen_string_literal: true

def caesar_cipher(sentence_to_be_encoded, shift_count)
  in_ascii = to_ascii(sentence_to_be_encoded)
  shifted_characters = in_ascii.map { |char_number| shift_characters(char_number, shift_count) }
  shifted_characters.map(&:chr).join
end

def to_ascii(string) = string.bytes

def shift_characters(char_number, shift_count)
  return char_number unless char_number.between?(65, 90) || char_number.between?(97, 122)

  base = char_number < 91 ? 65 : 97
  (((char_number - base) + shift_count) % 26) + base
end

caesar_cipher('What a string!', 5)
