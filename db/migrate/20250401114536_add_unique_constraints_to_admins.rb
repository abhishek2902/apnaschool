class AddUniqueConstraintsToAdmins < ActiveRecord::Migration[8.0]
  def change
    add_index :admins, :mobile, unique: true
    add_index :admins, :roll, unique: true
    add_index :admins, :email, unique: true
  end
end
