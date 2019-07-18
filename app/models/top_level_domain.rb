class TopLevelDomain < ApplicationRecord
  belongs_to :country

  validates :name, presence: true
end
