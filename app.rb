require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get "/" do
  Player.all().each() do |x|
    x.destroy()
  end
  Game.all().each() do |x|
    x.destroy()
  end
  erb(:index)
end

post '/login' do
  @game = Game.create
  @game.players.create(name: params["name1"])
  @game.players.create(name: params["name2"])
  @game.players.create(name: params["name3"])
  @game.players.create(name: params["name4"])
  if Player.all.length != 4
    redirect '/'
  end
  @game.start
  redirect '/new_trick'
end

get '/new_trick' do
  @game = Game.first
  # if @game.end_of_game  # WRITE THIS METHOD
  #   erb :gameover
  # elsif @game.end_of_round # WRITE THIS METHOD
  #   erb :roundover
  # else
    erb :play_trick
  # end
end

post '/play_trick' do
  game = Game.first
  @player = Player.find_by(player_num: game.turn)
  card = params['card']

  card.update(lead: true)
  # check to see if card is legal play
  if ! card.legit # WRITE THIS METHOD
    card.update(lead: false)
    redirect back
  end

  # card is legit. play the card.
  @player.play_card(card)

  # if end of trick, score & redirect to card_table; otherwise move on to next player and show erb again
  if Card.all.in_play.length == 4 # end of trick
    game.score
    redirect '/new_trick'
  else
    game.next_player # WRITE THIS METHOD
    erb :play_trick
  end
end
