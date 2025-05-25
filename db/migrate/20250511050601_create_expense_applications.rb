class CreateExpenseApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :expense_applications do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :amount, null: false
      t.string :purpose, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
