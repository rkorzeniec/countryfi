# frozen_string_literal: true

module Users
  class PreferencesForm
    include ActiveModel::Validations

    ATTRIBUTES = %i[countries color public_profile].freeze
    COUNTRIES = {
      all: 'all',
      un: 'un_member',
      independent: 'independent'
    }.freeze

    attr_accessor(*ATTRIBUTES)

    validates :countries, presence: true, inclusion: { in: COUNTRIES.values }
    validates :color,
              format: { with: /\A#([a-fA-F0-9]{3}|[a-fA-F0-9]{6})\z/ },
              allow_nil: true

    def initialize(user, params = {})
      @user = user
      ATTRIBUTES.each do |attribute|
        send("#{attribute}=", params[attribute])
      end
    end

    def save
      valid? ? user.update(params) : false
    end

    def persisted?
      false
    end

    private

    attr_reader :user

    def params
      {
        color: color,
        countries_cluster: countries,
        public_profile: public_profile
      }
    end
  end
end
