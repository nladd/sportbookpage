class CreateStatsMappings < ActiveRecord::Migration
  def self.up
    create_table :stats_mappings do |t|
      t.string :stats_table
      t.string :stats_type
      t.string :stats_name
      t.string :stats_field
      t.string :sport

      t.timestamps
    end
  end

  def self.down
    drop_table :stats_mappings
  end
end
