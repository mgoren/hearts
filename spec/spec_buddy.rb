ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

RSpec.configure do |config|
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
