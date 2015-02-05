class Player < ActiveRecord::Base
  has_many :cards
  belongs_to :game

  validates_presence_of :name

  def play_card(card)
    card.update(in_play: true)
  end

end
