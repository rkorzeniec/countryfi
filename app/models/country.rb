class Country < ActiveRecord::Base
  has_many :checkins
  has_many :currencies
  has_many :top_level_domains
  has_many :country_languages
  has_many :country_calling_codes
  has_many :border_countries
  has_many :country_alternative_spellings

  scope :european, -> { where(region: 'Europe') }
  scope :south_american, -> { where(subregion: 'South America') }
  scope :asian, -> { where(region: 'Asia') }
  scope :oceanian, -> { where(region: 'Oceania') }
  scope :african, -> { where(region: 'Africa') }
  scope :antarctican, -> { where(region: 'Antarctica') }
  scope :north_american, -> do
    where(
      [
        "region = 'Americas' AND "\
        "subregion = 'Northern America' OR "\
        "subregion = 'Central America' OR "\
        "subregion = 'Caribbean'"
      ]
    )
  end

  def self.find_by_any(name)
    where(
      "name_common LIKE ?
      OR name_official LIKE ?
      OR cca2 LIKE ?
      OR ccn3 LIKE ?
      OR cca3 LIKE ?
      OR cioc LIKE ?",
      "%#{name}%", "%#{name}%", "%#{name}%",
      "%#{name}%", "%#{name}%", "%#{name}%"
    ).first
  end
end
