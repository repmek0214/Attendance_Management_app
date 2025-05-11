class CreateAttendanceCorrections < ActiveRecord::Migration[7.1]
  def change
    create_table :attendance_corrections do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.datetime :corrected_in
      t.datetime :corrected_out
      t.string :reason
      t.integer :status

      t.timestamps
    end
  end
end
