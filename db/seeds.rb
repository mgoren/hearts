suits = ["heart", "spade", "club", "diamond"]
suits.each do |suit|
  rank = 2
  13.times do
    Card.create(:suit => suit, :rank => rank)
    rank += 1
  end
end
