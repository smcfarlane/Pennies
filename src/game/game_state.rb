require_relative '../table/deck'
require_relative '../rules'
require 'json'

class GameState
  attr_accessor :game, :players
  def initialize players, game
    @players = players
    @game = game
  end

  def set_json_state
    { players: @players, game: @game }.to_json
  end
end

class GameStateNew
  attr_accessor :game, :players
  def initialize players
    @players = players
    @deck = Deck.new(@players.count / 2)
    @game = {
      current_player: 0,
      deck: @deck.cards,
      discard_pile: [@deck.draw_cards(1)],
      winner: false,
      round: 1,
      round_rules: Rules::rules(1),
      table: {

      }
    }
  end
end

class GameStateExisting
  attr_accessor :game, :players
  def initialize game, players
    @game = game
    @players = players
  end
end
