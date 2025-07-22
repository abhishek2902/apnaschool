class AddDefaultLikesToGrievances < ActiveRecord::Migration[8.0]
  def change
    change_column_default :grievances, :likes, 0
  end
end
