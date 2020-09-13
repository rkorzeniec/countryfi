# frozen_string_literal: true

class VisitedCountriesQuery
  def initialize(user)
    @user = user
  end

  def count_by_year
    Rails.cache.fetch(cache_key, expires_in: 1.week) do
      user_checkins.group('year(checkins.checkin_date)').count
    end
  end

  private

  attr_reader :user

  def user_checkins
    @user_checkins ||=
      user
        .past_checkins
        .joins(:country)
        .merge(Country.send(user.countries_preference))
  end

  def cache_key
    [
      self.class.to_s.underscore, user.id, user_checkins.last&.id
    ].compact.join('/')
  end
end
