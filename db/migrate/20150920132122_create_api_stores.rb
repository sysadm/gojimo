class CreateApiStores < ActiveRecord::Migration
  def change
    create_table :api_stores do |t|
      t.string :link
      t.string :last_modified
      t.text :raw

      t.timestamps null: false
    end
  end
end
