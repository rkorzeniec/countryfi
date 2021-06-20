# frozen_string_literal: true

class TimelineCheckinsQuery
  ALLOWED_SCOPES = %w[
    african antarctican asian european north_american oceanian south_american
  ].freeze

  def initialize(user, options: {})
    @user = user
    @options = options
  end

  def query
    user
      .checkins
      .merge(checkins_scope)
      .joins(:country)
      .includes(:country)
      .order(checkin_date: :desc)
      .page(options[:page]).per(20)
  end

  def checkins_scope
    return Checkin.send(options[:scope]) if ALLOWED_SCOPES.include?(options[:scope])

    Checkin.all
  end

  private

  attr_reader :user, :options
end
