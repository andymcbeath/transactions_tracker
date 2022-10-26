class ChangePointsAvailable < ActiveRecord::Migration[7.0]
  def change
    remove_column :points, :points_available_integer, :string
    add_column :points, :points_available, :integer
  end
end
