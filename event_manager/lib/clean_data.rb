# frozen_string_literal: true

# This Module contains methods which formats the invalid data into a valid format.
module CleanData
  # This Class formats the invalid zipcode to a valid zipcode.
  class Zipcode
    class << self
      def format_zipcode(zipcode)
        zipcode.rjust(5, '0')[0..4]
      end
    end
  end

  # This Class formats the invalid phone number to a valid phone number.
  class PhoneNumber
    class << self
      def format_phone_number(phone_number)
        phone_number = phone_number.delete('^0-9')
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
    end
  end

  # This Class filters out the date, month, year, hour, minute & weekday from the argument.
  class DateAndTime
    class << self
      def format_time(date_time)
        DateTime.strptime(date_time, '%m/%d/%y %k:%M')
      end

      def hour(date_time)
        format_time(date_time).hour
      end

      def wday(date_time)
        format_time(date_time).wday
      end
    end
  end
end
