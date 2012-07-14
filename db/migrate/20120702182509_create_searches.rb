class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :query
      t.string :encoded_query

      t.timestamps
    end
  end
end
