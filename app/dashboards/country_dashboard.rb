# frozen_string_literal: true

require 'administrate/base_dashboard'

class CountryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    checkins: Field::HasMany,
    currencies: Field::HasMany,
    top_level_domains: Field::HasMany,
    country_languages: Field::HasMany,
    country_calling_codes: Field::HasMany,
    border_countries: Field::HasMany,
    country_alternative_spellings: Field::HasMany,
    id: Field::Number,
    name_common: Field::String,
    name_official: Field::String,
    cca2: Field::String,
    ccn3: Field::String,
    cca3: Field::String,
    cioc: Field::String,
    capital: Field::String,
    region: Field::String,
    subregion: Field::String,
    demonym: Field::String,
    landlocked: Field::Boolean,
    area: Field::Number.with_options(decimals: 2),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    latitude: Field::String.with_options(searchable: false),
    longitude: Field::String.with_options(searchable: false)
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[id name_common].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name_common
    name_official
    cca2
    ccn3
    cca3
    cioc
    capital
    region
    subregion
    demonym
    landlocked
    area
    created_at
    updated_at
    latitude
    longitude
    checkins
    currencies
    top_level_domains
    country_languages
    country_calling_codes
    border_countries
    country_alternative_spellings
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    checkins
    currencies
    top_level_domains
    country_languages
    country_calling_codes
    border_countries
    country_alternative_spellings
    name_common
    name_official
    cca2
    ccn3
    cca3
    cioc
    capital
    region
    subregion
    demonym
    landlocked
    area
    latitude
    longitude
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing 'open:'
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how countries are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(country)
  #   'Country ##{country.id}'
  # end

  def display_resource(country)
    country.name_common
  end
end
