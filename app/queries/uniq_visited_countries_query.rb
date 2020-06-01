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
    visited_country_checkins.each_with_object(Hash.new(0)) do |result, hash|
      hash[result.year] += 1
    end
  end

  def visited_country_checkins
    Checkin.select(
      "country_id, ANY_VALUE(year(checkins.checkin_date)) AS 'year'"
    ).where(
      'user_id = :user_id AND checkin_date <= :now',
      user_id: user.id,
      now: Time.current
    ).group('country_id')
  end

  def cache_key
    [
      self.class.to_s.underscore, user.id, user.visited_checkins.last&.id
    ].compact.join('/')
  end
end
