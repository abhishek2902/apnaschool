class CreateNotices < ActiveRecord::Migration[8.0]
  def change
    create_table :notices do |t|
      t.string :title
      t.text :text
      t.integer :likes, default: 0

      t.timestamps
    end
  end
end
