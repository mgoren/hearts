require 'spec_buddy'

describe Card do
  it {should belong_to :player}

  describe '#in_play' do
    it 'should return only cards that are in play' do
      c1 = Card.create(suit: "club", rank: 2)
      c2 = Card.create(suit: "heart", rank: 2, in_play: true)
      c3 = Card.create(suit: "spade", rank: 12)
      c4 = Card.create(suit: "club", rank: 3)
      expect(Card.all.in_play.first).to eq(c2)
    end
  end

  describe '#lead' do
    it 'should return the card that was led' do
      c1 = Card.create(suit: "club", rank: 2, in_play: true, lead: true)
      c2 = Card.create(suit: "heart", rank: 2, in_play: true)
      c3 = Card.create(suit: "spade", rank: 12, in_play: true)
      c4 = Card.create(suit: "club", rank: 3, in_play: true)
      expect(Card.all.led.first).to eq (c1)
    end
  end

  describe '#suit' do
    it 'checks for suit in player hand, returns empty if it is not there' do
      player = Player.create(name: "Tina", player_num: 1)
      player.cards.create(suit: "club")
      player.cards.create(suit: "spade")
      expect(player.cards.suit("diamond")).to eq([])
    end

    it 'checks for suit in player hand, returns empty if it is not there' do
      player = Player.create(name: "Tina", player_num: 1)
      c1 = player.cards.create(suit: "club")
      c2 = player.cards.create(suit: "club")
      c3 = player.cards.create(suit: "spade")
      expect(player.cards.suit("club")).to eq([c2, c1])
    end
  end

  describe '#legit' do
    it 'checks that the player who led has a legit play' do #
      player = Player.create(name: "Tina", player_num: 1)
      c1 = player.cards.create(suit: "club", lead: true)
      c2 = player.cards.create(suit: "club")
      c3 = player.cards.create(suit: "spade")
      expect(c1.legit).to eq(true)
    end

    it 'checks that a player not following suit cannot make a non-legit play' do
      player = Player.create(name: "Tina", player_num: 1)
      c1 = player.cards.create(suit: "club", lead: true)
      c2 = player.cards.create(suit: "club")
      c3 = player.cards.create(suit: "spade")
      expect(c3.legit).to eq(false)
    end

    it 'checks that the player is following suit when possible' do
      player1 = Player.create(name: "Tina", player_num: 1)
      c1 = player1.cards.create(suit: "spade", lead: true)
      player2 = Player.create(name: "Mike", player_num: 2)
      c2 = player2.cards.create(suit: "spade")
      c3 = player2.cards.create(suit: "heart")
      expect(c2.legit).to eq(true)
      expect(c3.legit).to eq(false)
    end

    it 'checks that the player can play a card of another suit if not possible to follow suit' do
      player1 = Player.create(name: "Tina", player_num: 1)
      c1 = player1.cards.create(suit: "spade", lead: true)
      player2 = Player.create(name: "Mike", player_num: 2)
      c2 = player2.cards.create(suit: "club")
      c3 = player2.cards.create(suit: "heart")
      expect(c3.legit).to eq(true)
    end
  end

end
