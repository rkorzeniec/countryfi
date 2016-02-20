class Country < ActiveRecord::Base
  has_many :checkins

  def self.find_by_any(name)
    where(
      "name_common LIKE ?
      OR name_official LIKE ?
      OR cca2 LIKE ?
      OR ccn3 LIKE ?
      OR cca3 LIKE ?
      OR cioc LIKE ?",
      "%#{name}%", "%#{name}%", "%#{name}%",
      "%#{name}%", "%#{name}%", "%#{name}%").first
  end
end
