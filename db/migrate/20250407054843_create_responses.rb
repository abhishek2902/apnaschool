class CreateResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :responses do |t|
      t.references :attempt, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.string :selected_option

      t.timestamps
    end
  end
end
