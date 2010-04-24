class CreateChallenges < ActiveRecord::Migration
  def self.up
    create_table :challenges do |t|
      t.integer :challengee_id
      t.integer :challenger_id
      t.integer :event_id
      t.float :amount
      t.float :home_spread
      t.timestamp :end_date_time

      t.timestamps
    end
  end

  def self.down
    drop_table :challenges
  end
end
