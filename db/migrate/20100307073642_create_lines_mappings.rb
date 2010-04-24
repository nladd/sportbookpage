class CreateLinesMappings < ActiveRecord::Migration
  def self.up
    create_table :lines_mappings do |t|
      t.string :sport
      t.string :wagering_table

      t.timestamps
    end
  end

  def self.down
    drop_table :lines_mappings
  end
end
