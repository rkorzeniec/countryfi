module CheckinsHelper
  def country_name_lookup
    CountryIDLookuper.lookup(params[:country]) unless params[:country].nil?
  end
end
