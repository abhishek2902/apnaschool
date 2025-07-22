class CreateGrievances < ActiveRecord::Migration[8.0]
  def change
    create_table :grievances do |t|
      t.string :name
      t.text :text
      t.boolean :flag
      t.integer :likes
      t.datetime :date

      t.timestamps
    end
  end
end
