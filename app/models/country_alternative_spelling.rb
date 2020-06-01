# frozen_string_literal: true

class CountryAlternativeSpelling < ApplicationRecord
  belongs_to :country

  validates :name, presence: true
end
