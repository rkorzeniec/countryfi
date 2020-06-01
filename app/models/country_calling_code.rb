# frozen_string_literal: true

class CountryCallingCode < ApplicationRecord
  belongs_to :country

  validates :calling_code, presence: true
end
