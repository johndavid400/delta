class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.decimal :balance
      t.integer :allocation_rate
      t.decimal :principal
      t.integer :user_id

      t.timestamps
    end
  end
end
