# frozen_string_literal: true

class TopLevelDomain < ApplicationRecord
  belongs_to :country

  validates :name, presence: true
end
