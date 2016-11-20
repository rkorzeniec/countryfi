module CheckinsHelper
  def selected_country(checkin = nil)
    checkin.nil? ? CountryIDLookuper.lookup(params[:country]) : checkin.country_id
  end
end
