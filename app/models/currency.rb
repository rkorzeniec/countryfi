# frozen_string_literal: true
class Currency < ApplicationRecord
  belongs_to :country

  validates :code, presence: true
end
