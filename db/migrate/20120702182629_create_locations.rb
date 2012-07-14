class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :encoded_name
      t.references :search

      t.timestamps
    end
    add_index :locations, :search_id
  end
end
