class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.integer :classname
      t.integer :roll
      t.integer :age
      t.date :dateofbirth
      t.string :sex
      t.string :fathername
      t.string :mothername
      t.text :address

      t.timestamps
    end
  end
end
