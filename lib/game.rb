class Game < ActiveRecord::Base
  has_many :players

  def start
    self.deal
    first_player = Player.find(Card.find_by(suit: "club", rank: 2).player_id).player_num
    self.update(turn: first_player)
    self.players.each {|player| player.update(score: 0) }
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

    score = winning_player.score
    cards.each do |card|
      score += card.point_value
    end
    winning_player.update(score: score)

    # remove played cards from players' hands
    cards.each do |card|
      card.update(player_id: nil, in_play: false, lead: false)
    end

    # update turn token
    self.update(turn: winning_player.player_num)

  end

  def next_player
    next_player_num = self.turn + 1
    next_player_num = 1 if next_player_num == 5
    self.update(turn: next_player_num)
    Player.find_by(player_num: next_player_num)
  end

  def end_of_game
    Player.all.each do |player|
      if player.game_score >= 100
        return true
      end
    end
    return false
  end

  def end_of_round
    round_score = 0
    self.players.each { |player| round_score += player.score }
    if Player.first.cards.length == 0

      # check for shooting moon
      self.players.each do |player|
        if player.score == 26
          self.players.each do |playa|
            if playa != player
              playa.update(score: 26)
            end
            player.update(score: 0)
          end
        end
      end


      self.players.each do |player|
        new_game_score = player.game_score + player.score
        player.update(game_score: new_game_score)
      end
      return true
    else
      return false
    end
  end


end
