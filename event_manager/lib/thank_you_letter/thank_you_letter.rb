# frozen_string_literal: true

require_relative 'government_representatives'

# This Class generates a "Thank You!" letter for all the attendees.
class ThankYouLetter
  private

  include CleanData

  def initialize(name, zipcode)
    @name = name
    @zipcode = zipcode
    @representatives = GovernmentRepresentatives.new
    @legislators = @representatives.legislators(@zipcode)
  end

  def save_thank_you_letters(id, form_letter)
    FileUtils.mkdir_p('output/thank_you_letters') unless Dir.exist?('output/thank_you_letters')

    filename = "output/thank_you_letters/thanks_#{id}.html"

    File.open(filename, 'w') do |file|
      file.puts form_letter
    end
  end

  attr_reader :name, :legislators

  public

  def generate_output(id)
    template_letter = File.read('form_letter.erb')
    erb_template = ERB.new template_letter
    form_letter = erb_template.result(binding)
    save_thank_you_letters(id, form_letter)
  end
end
