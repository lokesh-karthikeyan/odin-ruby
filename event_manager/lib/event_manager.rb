# frozen_string_literal: true

require 'csv'

puts 'Event Manager Initialized!'
puts ''

contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

contents.each do |row|
  name = row[:first_name]
  zipcode = row[:zipcode]
  puts "#{name} lives in \"#{zipcode}\""
end
