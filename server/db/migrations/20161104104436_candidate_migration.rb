require "active_record"

class CandidateMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :image_url
      t.integer :intelligence
      t.integer :charisma
      t.integer :willpower
      t.integer :campaigns_won
    end



  end
end
