module CheckinsHelper
  def country_name_lookup
    CountryIDLookuper.new(params[:country]).lookup unless params[:country].nil?
  end
end
