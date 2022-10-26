class CreateTransactionsTable < ActiveRecord::Migration[7.0]
  def change
    add_index :transactions, :payer
  end
end
