dictionary = %w[below down go going horn how howdy it i low own part partner sit]

def substrings(string, array)
  array_of_strings = string.downcase.split(' ')
  array.each_with_object(Hash.new(0)) do |word, key_for_hash|
    substring_length = array_of_strings.grep(/#{word}/i).length
    key_for_hash[word] = substring_length if substring_length.positive?
  end
end

substrings('below', dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)
