# frozen_string_literal: true
class Country < ApplicationRecord
  has_many :checkins, dependent: :restrict_with_error
  has_many :currencies, dependent: :restrict_with_error
  has_many :top_level_domains, dependent: :restrict_with_error
  has_many :country_languages, dependent: :destroy
  has_many :country_calling_codes, dependent: :destroy
  has_many :border_countries, dependent: :destroy
  has_many :country_alternative_spellings, dependent: :destroy

  scope :european, -> { where(region: 'Europe') }
  scope :south_american, -> { where(subregion: 'South America') }
  scope :asian, -> { where(region: 'Asia') }
  scope :oceanian, -> { where(region: 'Oceania') }
  scope :african, -> { where(region: 'Africa') }
  scope :antarctican, -> { where(region: 'Antarctica') }
  scope :north_american, lambda {
    where(
      [
        "region = 'Americas' AND "\
        "subregion = 'Northern America' OR "\
        "subregion = 'Central America' OR "\
        "subregion = 'Caribbean'"
      ]
    )
  }

  def self.find_by_any(name)
    find_by(
      "name_common LIKE ?
      OR name_official LIKE ?
      OR cca2 LIKE ?
      OR ccn3 LIKE ?
      OR cca3 LIKE ?
      OR cioc LIKE ?",
      "%#{name}%", "%#{name}%", "%#{name}%",
      "%#{name}%", "%#{name}%", "%#{name}%"
    )
  end

  def flag_image_path
    file = Rails.root.join('app/assets/images/flags', "#{cca2.upcase}.png")
    flag_path = File.exist?(file) ? "flags/#{cca2.upcase}.png" : 'flags/unknown.png'

    ActionController::Base.helpers.image_path(flag_path)
  end
end
