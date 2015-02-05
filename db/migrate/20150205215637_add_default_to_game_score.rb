class AddDefaultToGameScore < ActiveRecord::Migration
  def change
    change_column :players, :game_score, :integer, default: 0
  end
end
