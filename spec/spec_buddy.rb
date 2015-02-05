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
        Card.create(:suit => suit, :rank => rank)
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
