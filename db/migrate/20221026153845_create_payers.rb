class CreatePayers < ActiveRecord::Migration[7.0]
  def change
    create_table :payers do |t|
      t.string :payer
      t.integer :points
      t.datetime :timestamp

      t.timestamps
    end
  end
end
