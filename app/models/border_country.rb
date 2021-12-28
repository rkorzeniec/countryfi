# frozen_string_literal: true

class BorderCountry < ApplicationRecord
  belongs_to :country
  belongs_to :border_country, class_name: 'Country'

  delegate :name_common, to: :border_country
end
