class CreateCardsAndPlayersAndGames < ActiveRecord::Migration
  def change

    create_table :games do |t|
      t.column :turn, :integer, default: 1
      t.timestamps
    end

    create_table :players do |t|
      t.column :name, :string
      t.column :player_num, :integer
      t.column :score, :integer, default: 0
      t.column :game_id, :integer
      t.timestamps
    end

    create_table :cards do |t|
      t.column :suit, :string
      t.column :rank, :integer
      t.column :player_id, :integer
      t.column :in_play, :boolean, default: false
      t.timestamps
    end

    add_index :players, :game_id
    add_index :players, :score
    add_index :players, :player_num
    add_index :cards, :player_id
    add_index :cards, :in_play

  end
end
