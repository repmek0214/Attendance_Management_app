class CreateShiftRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :shift_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.date :shift_date
      t.datetime :start_time
      t.datetime :end_time
      t.string :reason
      t.integer :status

      t.timestamps
    end
  end
end
