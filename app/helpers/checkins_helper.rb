module CheckinsHelper
  def country_name_lookup
    CountryNameLookuper.new(params[:country]).lookup unless params[:country].nil?
  end
end
