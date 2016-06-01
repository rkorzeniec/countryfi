class AddTopLevelDomainsTable < ActiveRecord::Migration
  def change
    create_table :top_level_domains do |t|
      t.belongs_to :country, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
