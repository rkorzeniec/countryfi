# frozen_string_literal: true
module CheckinsHelper
  def selected_country(checkin = nil)
    if checkin.try(:country_id).nil?
      CountryIDLookuper.lookup(params[:country])
    else
      checkin.country_id
    end
  end
end
