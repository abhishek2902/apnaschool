class CreateReplies < ActiveRecord::Migration[8.0]
  def change
    create_table :replies do |t|
      t.string :name
      t.text :text
      t.datetime :date

      t.timestamps
    end
  end
end
