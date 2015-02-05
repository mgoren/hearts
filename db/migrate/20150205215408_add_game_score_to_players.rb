class AddGameScoreToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :game_score, :integer
  end
end
