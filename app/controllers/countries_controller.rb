class CountriesController < ApplicationController
  def show
    @country = Country.find(params[:id])

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
