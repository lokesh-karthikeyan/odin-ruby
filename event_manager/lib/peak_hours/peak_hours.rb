# frozen_string_literal: true

# This Class finds the peakest hours, when the attendees registered the most.
class PeakHours
  private

  @hours_list = Hash.new(0)

  class << self
    private

    def find_peak_hours
      peak_hours = hours_list.select { |_hour, count| count == hours_list.values.max }.keys
      "The peak hour(s), when most attendees registered are '#{peak_hours.join(', ')}'."
    end

    def save_peak_hour(peak_hour_statement)
      FileUtils.mkdir_p('output/peak_hours') unless Dir.exist?('output/peak_hours')

      filename = 'output/peak_hours/peak_hours.txt'

      File.open(filename, 'w') do |file|
        file.puts peak_hour_statement
      end
    end

    public

    attr_accessor :hours_list

    def generate_output
      peak_hour_statement = find_peak_hours
      save_peak_hour(peak_hour_statement)
    end
  end

  def initialize(hour)
    self.class.hours_list[hour] += 1
  end
end
