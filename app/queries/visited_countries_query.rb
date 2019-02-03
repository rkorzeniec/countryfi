class VisitedCountriesQuery
  def initialize(user)
    @user = user
  end

  def count_by_year
    visited_country_checkins.group('year(checkins.checkin_date)').count
  end

  private

  attr_reader :user

  delegate :checkins, to: :user, prefix: true

  def visited_country_checkins
    user_checkins.visited
  end
end
