class AddMobileToTeachers < ActiveRecord::Migration[8.0]
  def change
    add_column :teachers, :mobile, :string

    # Add unique constraint
    add_index :teachers, :mobile, unique: true
    add_index :teachers, :roll, unique: true  # Ensuring roll is unique
    add_index :teachers, :email, unique: true # Ensuring email is unique
  end
end
