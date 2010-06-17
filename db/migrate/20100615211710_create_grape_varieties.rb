class CreateGrapeVarieties < ActiveRecord::Migration
  def self.up
    create_table :grape_varieties do |t|
      t.timestamps
      t.string :name
      t.string :wine_type #red or white
    end
  end

  def self.down
    drop_table :grape_varieties
  end
end
