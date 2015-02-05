class AddPointValueToCards < ActiveRecord::Migration
  def change
    add_column :cards, :point_value, :integer
  end
end
