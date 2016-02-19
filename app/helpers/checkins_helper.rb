module CheckinsHelper
  def country_name_lookup
    CountryNameLookuper.new(params[:country]).lookup
  end
end
