class AddGrievanceIdToReplies < ActiveRecord::Migration[8.0]
  def change
    add_reference :replies, :grievance, null: false, foreign_key: true
  end
end
