class Card < ActiveRecord::Base
  belongs_to :player

  scope(:in_play, -> do
    where(in_play: true)
  end)

  scope(:led, -> do
    where(lead: true)
  end)

  scope(:suit, lambda do |suit|
    where(suit: suit)
  end)

  default_scope { order('suit','rank') }

  def legit # update later to add no first blood, no leading hearts until broken, 2 of clubs first
    card = self
    lead_suit = Card.all.led.first.suit
    player = Player.find(card.player_id)

    if player.cards.suit(lead_suit) != [] # player has cards of lead suit in hand
      if card.suit == lead_suit
        return true
      else
        return false
      end
    else # player does not have cards of lead suit in hand
      return true
    end



  end
end
