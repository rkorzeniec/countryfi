# frozen_string_literal: true

module CheckinsHelper
  def selected_country(checkin = nil)
    checkin&.country_id.presence || CountryIDLookuper.lookup(params[:country])
  end
end
