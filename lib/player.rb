class Player < ActiveRecord::Base
  has_many :cards
  belongs_to :game
  before_save :capitalize_name

  validates_presence_of :name

  def play_card(card)
    card.update(in_play: true)
  end

  def card_played
    Card.all.in_play.each do |card|
      if Player.find(card.player_id) == self
        return card
      end
    end
    return nil
  end

  private

  define_method(:capitalize_name) do
    self.name=(name.split(/(\W)/).map(&:capitalize).join)
  end

end
