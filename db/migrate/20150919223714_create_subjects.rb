class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :system_id
      t.string :name
      t.string :link
      t.string :icon
      t.string :colour

      t.timestamps null: false
    end
  end
end
