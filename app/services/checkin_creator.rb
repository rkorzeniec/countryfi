class CheckinCreator
  attr_reader :checkin, :country, :user

  def initialize(user, params = {})
    @country = find_country(params.fetch(:country))
    @user = user
    @checkin = Checkin.new
  end

  def process
    checkin.country = country
    checkin.user = user
    checkin.save!
  end

  private

  def find_country(name)
    Country.find_by_any(name)
  end
end
