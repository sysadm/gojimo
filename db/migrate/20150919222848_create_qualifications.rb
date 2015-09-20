class CreateQualifications < ActiveRecord::Migration
  def change
    create_table :qualifications do |t|
      t.string :system_id
      t.string :name
      t.string :link
      t.integer :country_id
      t.integer :subjects_count

      t.timestamps null: false
    end
  end
end
