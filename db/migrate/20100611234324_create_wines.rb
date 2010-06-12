class CreateWines < ActiveRecord::Migration
  def self.up
    create_table :wines do |t|
      t.timestamps
      t.string :name,      :null => false
    end
  end

  def self.down
    drop_table :wines
  end
end
