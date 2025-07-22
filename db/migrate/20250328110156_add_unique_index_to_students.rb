class AddUniqueIndexToStudents < ActiveRecord::Migration[8.0]
  def change
    add_index :students, :email, unique: true
    add_index :students, :roll, unique: true
  end
end
