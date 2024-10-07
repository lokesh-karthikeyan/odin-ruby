def caesar_cipher(sentence_to_be_encoded, shift_count)
  in_ascii = sentence_to_be_encoded.bytes
  shifted_characters = in_ascii.map do |character|
    if character.between?(65, 90)
      if character + shift_count > 90
        shift_from_start = (character + shift_count) - 90
        64 + shift_from_start
      else
        character + shift_count
      end
    elsif character.between?(97, 122)
      if character + shift_count > 122
        shift_from_start = (character + shift_count) - 122
        96 + shift_from_start
      else
        character + shift_count
      end
    else
      character
    end
  end
  shifted_characters.map(&:chr).join
end

caesar_cipher('What a string!', 5)
