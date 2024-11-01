# frozen_string_literal: true

require_relative 'introduction'
require_relative 'available_colors'
require_relative 'rules'

# This Class contains methods that prints the initial introduction & thier roles.
class Prologue
  class << self
    include Introduction
    include AvailableColors

    def ai_as_encoder
      intro_and_roles('code breaker', 'code maker')
      Rules.rules_to_decoder
      print_available_colors
    end

    def ai_as_decoder
      intro_and_roles('code maker', 'code breaker')
      print_available_colors
      Rules.rules_to_encoder
    end
  end
end
