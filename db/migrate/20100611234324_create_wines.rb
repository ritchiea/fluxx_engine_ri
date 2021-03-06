class CreateWines < ActiveRecord::Migration
  def self.up
    create_table :wines do |t|
      t.timestamps
      t.string :name,      :null => false
      t.integer :grape_variety_id, :null => true
      t.datetime :locked_until, :null => true
      t.integer :locked_by_id, :null => true
    end
  end

  def self.down
    drop_table :wines
  end
end
