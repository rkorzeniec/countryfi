class UniqVisitedCountriesQuery
  def initialize(user)
    @user = user
  end

  def count_by_year
    visited_country_checkins.each_with_object(Hash.new(0)) do |result, hash|
      hash[result.year] += 1
    end
  end

  private

  attr_reader :user

  def visited_country_checkins
    Checkin.select(
      'country_id', 'year(checkins.checkin_date) AS year'
    ).where(
      'user_id = :user_id AND checkin_date <= :now',
      user_id: user.id,
      now: Time.current
    ).group(:country_id)
  end
end
