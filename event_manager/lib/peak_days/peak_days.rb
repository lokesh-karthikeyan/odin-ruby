# frozen_string_literal: true

# This Class finds the peakest days, when the attendees registered the most.
class PeakDays
  private

  @week_days_list = Hash.new(0)

  class << self
    private

    def find_peak_days
      peak_week_days = week_days_list.select { |_hour, count| count == week_days_list.values.max }.keys
      peak_day = []
      peak_week_days.each do |day|
        peak_day << Date::DAYNAMES[day.to_i]
      end
      "The peak day(s), when most attendees registered are on '#{peak_day.join(', ')}'."
    end

    def save_peak_day(peak_day_statement)
      FileUtils.mkdir_p('output/peak_days') unless Dir.exist?('output/peak_days')

      filename = 'output/peak_days/peak_days.txt'

      File.open(filename, 'w') do |file|
        file.puts peak_day_statement
      end
    end

    public

    attr_accessor :week_days_list

    def generate_output
      peak_day_statement = find_peak_days
      save_peak_day(peak_day_statement)
    end
  end

  def initialize(week_day)
    self.class.week_days_list[week_day] += 1
  end
end
