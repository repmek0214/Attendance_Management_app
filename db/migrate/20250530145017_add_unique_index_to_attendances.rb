class AddUniqueIndexToAttendances < ActiveRecord::Migration[7.1]
  def change
    add_index :attendances, [:user_id, :date], unique: true
  end
end
