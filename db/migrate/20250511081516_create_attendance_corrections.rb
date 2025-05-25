class CreateAttendanceCorrections < ActiveRecord::Migration[7.1]
  def change
    create_table :attendance_corrections do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false
      t.datetime :corrected_in, null: false
      t.datetime :corrected_out,  null: false
      t.string :reason , null: false
      t.integer :status, default: 0, null: false
    

      t.timestamps
    end
  end
end
