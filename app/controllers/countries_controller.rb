# frozen_string_literal: true
class CountriesController < ApplicationController
  skip_before_action :authenticate_user!

  layout 'country'

  def show
    @country = Country
               .preload(
                 :country_languages, :currencies, :country_calling_codes,
                 :top_level_domains, :country_alternative_spellings,
                 border_countries: :border_country
               ).find_by(cca2: params[:id])
    @geojson =
      File.read("app/assets/geojsons/#{country_cca3}.geo.json")
  end

  private

  def country_cca3
    ActionController::Base.helpers.sanitize(@country.cca3.downcase)
  end
end
