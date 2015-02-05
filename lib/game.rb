class Game < ActiveRecord::Base
  has_many :players

  def start
    self.deal
    first_player = Player.find(Card.find_by(suit: "club", rank: 2).player_id).player_num
    self.update(turn: first_player)
  end

  def deal
    deck = []
    Card.all.each do |card|
      deck << card
    end
    deck.shuffle!

    Player.all.each do |player|
      13.times do
        card = deck.pop
        player.cards << card
      end
    end
  end

  def score

    # score cards and add points to player who took the trick
    cards = Card.all.in_play
    player_who_led = Player.find_by(player_num: self.turn)
    player_who_led_id = player_who_led.id
    lead_suit = cards.find_by(player_id: player_who_led_id).suit

    highest_rank = 0
    cards.each do |card|
      if card.suit == lead_suit
        if card.rank > highest_rank
          highest_rank = card.rank
        end
      end
    end

    winning_card = cards.find_by(suit: lead_suit, rank: highest_rank)
    winning_player = Player.find(winning_card.player_id)

    score = 0
    cards.each do |card|
      score += card.point_value
    end
    winning_player.update(score: score)

    # remove played cards from players' hands
    cards.each do |card|
      card.update(player_id: nil, in_play: false)
    end

    # update turn token
    self.update(turn: winning_player.player_num)

  end


end
