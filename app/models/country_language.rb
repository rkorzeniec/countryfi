# frozen_string_literal: true
class CountryLanguage < ApplicationRecord
  belongs_to :country

  validates :name, presence: true

  def name_and_code
    "#{name} (#{code})"
  end
end
