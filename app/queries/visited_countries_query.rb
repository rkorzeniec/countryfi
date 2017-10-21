class VisitedCountriesQuery
  def initialize(user)
    @user = user
  end

  def count_by_year
    grouped_visited_countries.count(:country_id)
  end

  private

  attr_reader :user

  delegate :checkins, to: :user, prefix: true

  def grouped_visited_countries
    visited_country_checkins.group('year(checkins.checkin_date)')
  end

  def visited_country_checkins
    user_checkins.visited
  end
end
