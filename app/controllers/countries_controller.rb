class CountriesController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @country = Country
      .preload(
        :country_languages, :currencies, :country_calling_codes,
        :top_level_domains, :country_alternative_spellings,
        border_countries: :border_country
      ).find(params[:id])

    respond_to do |format|
      format.html
      format.json do
        render json: ActiveSupport::JSON.decode(
          File.read("app/assets/geojsons/#{@country.cca3}.geo.json")
        )
      end
    end
  end
end
