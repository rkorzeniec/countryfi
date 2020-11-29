# frozen_string_literal: true

module Users
  class NullUser
    def cache_key
      'null'
    end

    def countries
      Country.none
    end

    def countries_preference
      'all'
    end

    def id
      nil
    end

    def past_checkins
      Checkin.none
    end

    def public_profile?
      false
    end

    alias public_profile public_profile?
  end
end
