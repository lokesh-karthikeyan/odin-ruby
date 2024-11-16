# frozen_string_literal: true

require_relative 'clean_data'
require_relative 'thank_you_letter/thank_you_letter'
require_relative 'attendee_phone_number/attendee_phone_number'
require_relative 'peak_hours/peak_hours'
require_relative 'peak_days/peak_days'

# This Class manages the CSV file & passes the CSV file data to other classes.
class EventManager
  private

  attr_accessor :event_manager_start, :event_manager_end

  include CleanData

  def initialize
    @file_contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)
    @event_manager_start = 'Event Manager is now initialized.'
    @event_manager_end = "Output is generated successfully.
---------------------------------------------------------------------"
  end

  public

  def thank_you_letter
    puts event_manager_start
    @file_contents.each do |row|
      id = row[0].to_s
      name = row[:first_name].to_s
      zipcode = Zipcode.format_zipcode(row[:zipcode].to_s)
      save_letter = ThankYouLetter.new(name, zipcode)
      save_letter.generate_output(id)
    end
    puts event_manager_end
  end

  def attendee_phone_number
    puts event_manager_start
    @file_contents.each do |row|
      id = row[0].to_s
      name = row[:first_name].to_s
      phone_number = PhoneNumber.format_phone_number(row[:homephone].to_s)
      save_phone_number = AttendeePhoneNumber.new(name, phone_number)
      save_phone_number.generate_output(id)
    end
    puts event_manager_end
  end

  def peak_hour
    puts event_manager_start
    @file_contents.each do |row|
      reg_hours = DateAndTime.hour(row[:regdate].to_s)
      PeakHours.new(reg_hours)
    end
    PeakHours.generate_output
    puts event_manager_end
  end

  def peak_day
    puts event_manager_start
    @file_contents.each do |row|
      reg_days = DateAndTime.wday(row[:regdate].to_s)
      PeakDays.new(reg_days)
    end
    PeakDays.generate_output
    puts event_manager_end
  end
end

EventManager.new.thank_you_letter
EventManager.new.attendee_phone_number
EventManager.new.peak_hour
EventManager.new.peak_day
