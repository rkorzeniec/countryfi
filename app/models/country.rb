# frozen_string_literal: true

class Country < ApplicationRecord
  has_many :checkins, dependent: :restrict_with_error
  has_many :currencies, dependent: :restrict_with_error
  has_many :top_level_domains, dependent: :restrict_with_error
  has_many :country_languages, dependent: :destroy
  has_many :country_calling_codes, dependent: :destroy
  has_many :border_countries, dependent: :destroy
  has_many :country_alternative_spellings, dependent: :destroy

  scope :arranged_by_name, -> { order('name_common') }
  scope :european, -> { where(region: 'Europe') }
  scope :south_american, -> { where(subregion: 'South America') }
  scope :asian, -> { where(region: 'Asia') }
  scope :oceanian, -> { where(region: 'Oceania') }
  scope :african, -> { where(region: 'Africa') }
  scope :antarctican, -> { where(region: 'Antarctic') }
  scope :north_american, lambda {
    where("region = 'Americas' AND subregion <> 'South America'")
  }

  def self.find_by_any(name)
    find_by(
      "name_common LIKE :name
      OR name_official LIKE :name
      OR cca2 LIKE :name
      OR ccn3 LIKE :name
      OR cca3 LIKE :name
      OR cioc LIKE :name",
      name: "%#{name}%"
    )
  end

  def flag_image_path
    file = Rails.root.join('app/assets/images/flags', "#{cca2.upcase}.png")
    flag_path = File.exist?(file) ? "flags/#{cca2.upcase}.png" : 'flags/unknown.png'

    ActionController::Base.helpers.image_path(flag_path)
  end
end
