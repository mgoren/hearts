require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get "/" do
  Player.all.each do |x|
    x.destroy
  end
  Game.all.each do |x|
    x.destroy
  end
  Card.all.each do |x|
    x.update(lead: false, in_play: false, player_id: nil)
  end
  erb(:index)
end

post '/login' do
  @game = Game.create
  @game.players.create(name: params["name1"], player_num: 1)
  @game.players.create(name: params["name2"], player_num: 2)
  @game.players.create(name: params["name3"], player_num: 3)
  @game.players.create(name: params["name4"], player_num: 4)
  if Player.all.length != 4
    redirect '/'
  end
  @game.start
  redirect '/new_trick'
end

get '/new_trick' do
  @game = Game.first
  @player = Player.find_by(player_num: @game.turn)
  if @game.end_of_game
    erb :gameover
  elsif @game.end_of_round
    erb :roundover
  else
    erb :play_trick
  end
end

get '/play_trick' do
  game = Game.first
  @player = Player.find_by(player_num: game.turn)
  erb :play_trick
end

post '/play_trick' do
  game = Game.first
  current_player = Player.find_by(player_num: game.turn)
  card = Card.find(params['card'])
  card.update(in_play: true)
  if Card.all.in_play.length == 1
    card.update(lead: true)
  end

  # check to see if card is legal play
  if ! card.legit
    card.update(lead: false, in_play: false)
    @player = current_player
    
    redirect '/play_trick'
  end

  # card is legit. play the card.
  current_player.play_card(card)

  # if end of trick, score & redirect to card_table; otherwise move on to next player and show erb again
  if Card.all.in_play.length == 4 # end of trick
    game.score
    redirect '/new_trick'
  else
    @player = game.next_player
    erb :play_trick
  end
end
