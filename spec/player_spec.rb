require 'spec_buddy'

describe Player do
  it {should belong_to :game}
  it {should have_many :cards}
  it {should validate_presence_of :name}

  describe '#deal' do
    it 'should check that player has thirteen cards' do
      test_game = Game.create(turn: 1)
      test_player = Player.create(name: "Mike", player_num: 1, game_id: test_game.id )
      test_game.deal
      expect(test_player.cards.length).to eq(13)
    end
  end

  describe '#play_card' do
    it 'should set a card to in play after it has been played' do
      test_player = Player.create(name: "Mike", player_num: 1)
      test_card = Card.create(suit: "heart", rank: 4)
      test_player.play_card(test_card)
      expect(test_card.in_play).to(eq(true))
    end
  end

  describe '#capitalize_name' do
    it("will capitalize name") do
      player1 = Player.create({:name => "mike goren"})
      expect(player1.name()).to(eq("Mike Goren"))
    end
  end

  describe '#card_played' do
    it("will return card played that round by this player") do
      p1 = Player.create({:name => "mike"})
      c1 = p1.cards.create(suit: "heart", rank: 4, in_play: true)
      expect(p1.card_played).to eq(c1)
    end
  end


end
