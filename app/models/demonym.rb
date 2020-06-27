# frozen_string_literal: true

class Demonym < ApplicationRecord
  belongs_to :country

  validates :locale, :gender, :name, presence: true
end
