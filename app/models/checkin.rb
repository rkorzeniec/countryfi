# frozen_string_literal: true

class Checkin < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :country

  validates :user, presence: true
  validates :country, presence: true
  validates :checkin_date, presence: true

  scope :in_past, -> { where('checkin_date <= ?', Time.current) }
  scope :world, -> { joins(:country).merge(Country.all) }
  scope :asian, -> { joins(:country).merge(Country.asian) }
  scope :african, -> { joins(:country).merge(Country.african) }
  scope :antarctican, -> { joins(:country).merge(Country.antarctican) }
  scope :european, -> { joins(:country).merge(Country.european) }
  scope :oceanian, -> { joins(:country).merge(Country.oceanian) }
  scope :north_american, -> { joins(:country).merge(Country.north_american) }
  scope :south_american, -> { joins(:country).merge(Country.south_american) }

  # scope :un_member, -> { joins(:country).merge(Country.un_member) }
  # scope :independent, -> { joins(:country).merge(Country.independent) }
  def in_past?
    checkin_date <= Time.zone.today
  end
end
