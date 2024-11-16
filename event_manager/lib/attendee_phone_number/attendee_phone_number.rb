# frozen_string_literal: true

# This Class generates the attendee's phone number.
class AttendeePhoneNumber
  private

  def initialize(name, phone_number)
    @name = name
    @phone_number = phone_number
  end

  def save_phone_number(id_and_name_and_number)
    FileUtils.mkdir_p('output/attendees_phone_number') unless Dir.exist?('output/attendees_phone_number')

    filename = 'output/attendees_phone_number/attendees_phone_number.txt'

    File.open(filename, 'a') do |file|
      file.puts id_and_name_and_number
    end
  end

  public

  def generate_output(id)
    formatted_line = "#{id}. '#{@name}'s' contact number is '#{@phone_number}'."
    save_phone_number(formatted_line)
  end
end
