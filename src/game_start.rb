require_relative 'json'
require_relative 'players/players'
require_relative 'game/game_state'
require_relative 'game/game'
require_relative 'play/play'

file = File.read('game.json')
start = JSON.parse(file)

if start.is_a? Array
  players = Players.new start
  game_state = GameStateNew.new players
  play = ''
  game = Game.new game_state, play
  game.set_state
else
  players = Players.new start["players"]
  game_state = GameStateExisting.new start["game"], players
  play = Play.new start["play"], start["game"]["round"]
  game = Game.new game_state, play
  game.validate_play
  if game.play.valid?
    game.play!
    game.set_state
  else
    game.play.validator.results
  end
end
