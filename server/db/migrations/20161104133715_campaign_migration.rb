require "active_record"

class CampaignMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.integer :winning_candidate_id
      t.integer :losing_candidate_id
      t.timestamps null:false
    end
  end
end
