class Checkin < ActiveRecord::Base
  belongs_to :user
  belongs_to :country

  validates :user, presence: true
  validates :country, presence: true
  validates :checkin_date, presence: true

  scope :asian, -> { joins(:country).merge(Country.asian) }
  scope :african, -> { joins(:country).merge(Country.african) }
  scope :antarctican, -> { joins(:country).merge(Country.antarctican) }
  scope :european, -> { joins(:country).merge(Country.european) }
  scope :oceanian, -> { joins(:country).merge(Country.oceanian) }
  scope :north_american, -> { joins(:country).merge(Country.north_american) }
  scope :south_american, -> { joins(:country).merge(Country.south_american) }
  scope :visited, -> { where('checkin_date <= ?', Time.current) }
end
