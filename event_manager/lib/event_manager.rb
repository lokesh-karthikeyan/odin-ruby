# frozen_string_literal: true

require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def access_api_data
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = File.read('secret.key').strip
  civic_info
end

def legislators_by_zipcode(zipcode)
  civic_info = access_api_data
  begin
    civic_info.representative_info_by_address(address: zipcode, levels: 'country',
                                              roles: %w[legislatorUpperBody legislatorLowerBody]).officials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def clean_phone_number(phone_number)
  phone_number = phone_number.to_s.delete('^0-9')
  phone_number = if bad_number?(phone_number)
                   'X' * 10
                 elsif phone_number.length == 11 && phone_number[0] == '1'
                   phone_number[1..10]
                 else
                   phone_number
                 end

  "#{phone_number[0..2]}-#{phone_number[3..5]}-#{phone_number[6..]}"
end

def bad_number?(number)
  number.length < 10 || number.length > 11 || (number.length == 11 && number[0] != '1')
end

def registered_hour(date_time)
  date_time = DateTime.strptime(date_time, '%m/%d/%y %k:%M')
  date_time.hour
end

def peak_hour(reg_hour)
  peak_time = reg_hour.select { |_hour, count| count == reg_hour.values.max }.keys
  peak_time.join(', ')
end

puts 'Event Manager Initialized!'

contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

# template_letter = File.read('form_letter.erb')
# erb_template = ERB.new template_letter

reg_hour = Hash.new(0)

contents.each do |row|
  # id = row[0]
  # name = row[:first_name]
  # zipcode = clean_zipcode(row[:zipcode])
  # legislators = legislators_by_zipcode(zipcode)
  # form_letter = erb_template.result(binding)
  # save_thank_you_letter(id, form_letter)
  # phone_number = clean_phone_number(row[:homephone])
  # puts "#{name} : #{phone_number} || #{phone_number.length}"
  reg_date = row[:regdate]
  reg_hour[registered_hour(reg_date)] += 1
end

p peak_hour(reg_hour)
