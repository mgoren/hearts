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

  def legit
    card = self
    lead_suit = Card.all.led.first.suit
    player = Player.find(card.player_id)

    if player.cards.length == 13 && Card.all.in_play.length == 1
      if card.suit == "club" && card.rank == 2
        return true;
      else
        return false;
      end
    end

    unplayed_hearts = 0
    Player.all.each do |player|
      unplayed_hearts += player.cards.suit("heart").length
    end


    if player.cards.suit(lead_suit) != [] # player has cards of lead suit in hand
      if card.suit == lead_suit
        if card.suit == "heart" && Card.all.in_play.length == 1 && unplayed_hearts == 13
          return false
        else
          return true
        end
      else
        return false
      end
    else # player does not have cards of lead suit in hand
      if player.cards.length == 13 && card.suit == "heart"
        return false
      else
        return true
      end
    end

  def who_played
    Player.find(self.player_id)
  end


  end
end
