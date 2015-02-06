require 'spec_buddy'

describe Game do
  it {should have_many :players}

  describe '#start' do
    it 'set turn to the player with the two of clubs' do
      game = Game.create
      game.players.create(name: "Mike", player_num: 1)
      game.players.create(name: "Tina", player_num: 2)
      game.players.create(name: "Monster", player_num: 3)
      game.players.create(name: "Cookie", player_num: 4)
      game.start
      first_player = Player.find(Card.find_by(suit: "club", rank: 2).player_id).player_num
      expect(game.turn).to eq(first_player)
    end
  end

  describe '#score' do
    it 'should update player scores' do
      game = Game.create(turn: 1)
      p1 = game.players.create(name: "Mike", player_num: 1)
      p2 = game.players.create(name: "Tina", player_num: 2)
      p3 = game.players.create(name: "Monster", player_num: 3)
      p4 = game.players.create(name: "Cookie", player_num: 4)
      c1 = Card.create(suit: "club", rank: 2, in_play: true, point_value: 0)
      c2 = Card.create(suit: "heart", rank: 2, in_play: true, point_value: 1)
      c3 = Card.create(suit: "spade", rank: 12, in_play: true, point_value: 13)
      c4 = Card.create(suit: "club", rank: 3, in_play: true, point_value: 0)
      p1.cards << c1
      p2.cards << c2
      p3.cards << c3
      p4.cards << c4 # should take trick
      game.score
      p4.reload
      expect(p4.score).to eq(14)
    end

    it 'should update turn to next player' do
      game = Game.create(turn: 1)
      p1 = game.players.create(name: "Mike", player_num: 1)
      p2 = game.players.create(name: "Tina", player_num: 2)
      p3 = game.players.create(name: "Monster", player_num: 3)
      p4 = game.players.create(name: "Cookie", player_num: 4)
      c1 = Card.create(suit: "club", rank: 2, in_play: true, point_value: 0)
      c2 = Card.create(suit: "heart", rank: 2, in_play: true, point_value: 1)
      c3 = Card.create(suit: "spade", rank: 12, in_play: true, point_value: 13)
      c4 = Card.create(suit: "club", rank: 3, in_play: true, point_value: 0)
      p1.cards << c1
      p2.cards << c2
      p3.cards << c3
      p4.cards << c4 # should take trick
      game.score
      expect(game.turn).to eq(p4.player_num)
    end

    it 'should remove a card from player hand after it has been played' do
      game = Game.create(turn: 1)
      p1 = game.players.create(name: "Mike", player_num: 1)
      p2 = game.players.create(name: "Tina", player_num: 2)
      p3 = game.players.create(name: "Monster", player_num: 3)
      p4 = game.players.create(name: "Cookie", player_num: 4)
      c1 = Card.create(suit: "club", rank: 2, in_play: true, point_value: 0)
      c2 = Card.create(suit: "heart", rank: 2, in_play: true, point_value: 1)
      c3 = Card.create(suit: "spade", rank: 12, in_play: true, point_value: 13)
      c4 = Card.create(suit: "club", rank: 3, in_play: true, point_value: 0)
      p1.cards << c1
      p2.cards << c2
      p3.cards << c3
      p4.cards << c4 # should take trick
      game.score
      p1.reload
      expect(p1.cards.length).to(eq(0))
    end
  end

  describe '#next_player' do
    it 'should update the turn to the next player' do
      game = Game.create(turn: 4)
      p1 = game.players.create(name: "Mike", player_num: 1)
      p2 = game.players.create(name: "Tina", player_num: 2)
      p3 = game.players.create(name: "Monster", player_num: 3)
      p4 = game.players.create(name: "Cookie", player_num: 4)
      game.next_player
      expect(game.turn).to eq(1)
    end
  end

  describe '#end_of_game' do
    it 'should return true when a player has 100 or more points' do
      game = Game.create(turn: 1)
      p1 = Player.create(name: "Tina", game_score: 100)
      expect(game.end_of_game).to eq(true)
    end
  end

  describe '#end_of_round' do
    it 'should return true when the round is over' do
      game = Game.create(turn: 1)
      p1 = game.players.create(name: "Mike", player_num: 1, score: 13)
      p2 = game.players.create(name: "Tina", player_num: 2, score: 0)
      p3 = game.players.create(name: "Monster", player_num: 3, score: 0)
      p4 = game.players.create(name: "Cookie", player_num: 4, score: 13)
      expect(game.end_of_round).to eq(true)
    end

    it 'should add the scores from the round to the players total game score' do
      game = Game.create(turn: 1)
      p1 = game.players.create(name: "Mike", player_num: 1, score: 13)
      p2 = game.players.create(name: "Tina", player_num: 2, score: 0)
      p3 = game.players.create(name: "Monster", player_num: 3, score: 0)
      p4 = game.players.create(name: "Cookie", player_num: 4, score: 13)
      game.end_of_round
      expect(p1.game_score).to eq(13)
    end
  end

end
