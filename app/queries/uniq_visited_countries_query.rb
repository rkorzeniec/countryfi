# frozen_string_literal: true

class UniqVisitedCountriesQuery
  def initialize(user)
    @user = user
  end

  def count_by_year
    Rails.cache.fetch(cache_key, expires_in: 1.week) do
      calculate_countries_by_year
    end
  end

  private

  attr_reader :user

  def calculate_countries_by_year
    country_checkins.each_with_object(Hash.new(0)) do |result, hash|
      hash[result.year] += 1
    end
  end

  def country_checkins
    scope = checkins
    scope.group('country_id').order('year')
  end

  def checkins
    Checkin
      .joins(:country)
      .merge(Country.send(user.countries_preference))
      .select(checkins_select)
      .in_past
      .where(user: user)
  end

  def checkins_select
    "checkins.country_id, ANY_VALUE(year(checkins.checkin_date)) AS 'year'"
  end

  def cache_key
    [
      self.class.to_s.underscore, user.cache_key, user.past_checkins.last&.id
    ].compact.join('/')
  end
end
