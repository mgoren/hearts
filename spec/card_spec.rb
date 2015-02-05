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

end
