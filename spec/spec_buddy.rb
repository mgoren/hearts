ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

RSpec.configure do |config|

  config.before(:each) do
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
  end

  config.after(:each) do
    Card.all().each() do |x|
      x.destroy()
    end
    Player.all().each() do |x|
      x.destroy()
    end
    Game.all().each() do |x|
      x.destroy()
    end
  end
end
