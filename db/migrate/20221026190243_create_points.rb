class CreatePoints < ActiveRecord::Migration[7.0]
  def change
    create_table :points do |t|
      t.integer :points
      t.string :points_available_integer

      t.timestamps
    end
  end
end
