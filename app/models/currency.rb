class Currency < ActiveRecord::Base
  belongs_to :country

  validates :currency_code, presence: true
end
