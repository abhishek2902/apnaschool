class CreateTeachers < ActiveRecord::Migration[8.0]
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :email
      t.integer :roll
      t.integer :age
      t.date :dateofbirth
      t.string :sex
      t.string :fathername
      t.string :mothername
      t.text :address
      t.string :subject

      t.timestamps
    end
  end
end
