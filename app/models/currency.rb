class Currency < ActiveRecord::Base
  belongs_to :country

  validates :code, presence: true
end
