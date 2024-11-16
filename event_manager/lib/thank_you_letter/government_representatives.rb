# frozen_string_literal: true

# This Class can access the 'civicinfo_v2' from 'Google API' & returns the govt. representatives.
# The representatives are queried based on the zipcode.
class GovernmentRepresentatives
  def initialize
    @civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
    @civic_info.key = File.read('secret.key').strip
  end

  def legislators(zipcode)
    @civic_info.representative_info_by_address(address: zipcode, levels: 'country',
                                               roles: %w[legislatorUpperBody legislatorLowerBody]).officials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end
