class CreateScientificSets < ActiveRecord::Migration
  def change
    create_table :scientific_sets do |t|
      t.integer :subject_id
      t.integer :qualification_id

      t.timestamps null: false
    end
  end
end
