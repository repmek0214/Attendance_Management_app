class AddDefaultToAttendanceCorrectionStatus < ActiveRecord::Migration[7.1]
  def change
    change_column_default :attendance_corrections, :status, from: nil, to: 0
  end
end
