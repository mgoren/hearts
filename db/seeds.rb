suits = ["heart", "spade", "club", "diamond"]
suits.each do |suit|
  rank = 2
  13.times do
    card = Card.create(:suit => suit, :rank => rank)
    if card.suit == "heart"
      card.update(point_value: 1)
    elsif card.suit == "spade" && card.rank == 12
      card.update(point_value: 13)
    else
      card.update(point_value: 0)
    end
    rank += 1
  end
end
