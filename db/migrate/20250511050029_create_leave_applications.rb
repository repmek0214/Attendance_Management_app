class CreateLeaveApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_applications do |t|
      t.references :user, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :reason, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end