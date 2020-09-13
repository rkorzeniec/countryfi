# frozen_string_literal: true

module CacheFetch
  CACHE_EXPIRY = 1.week
  private_constant :CACHE_EXPIRY

  private

  def cache_fetch(method_name)
    Rails.cache.fetch(cache_key(method_name), expires_in: CACHE_EXPIRY) do
      Rails.logger.info(cache_key(method_name))
      yield
    end
  end

  def cache_key(method_name)
    [
      self.class.to_s.underscore,
      method_name,
      user.cache_key
    ].compact.join('/')
  end
end
