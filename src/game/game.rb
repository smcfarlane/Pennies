require_relative '../rules'
require_relative '../table/deck'
require 'uuid'

module Application
  class PenniesGame
    def initialize id, deck, players, room
      @id = id
      @deck = deck
      @players = players
      @room = room
      @round = 1
    end

    def deal
      @players.each {|player| player.plaery.hand = @deck.draw_cards}
    end

    def to_h
      {
        id: @id,
        players: @players.map {|player| player.to_h},
        room: @room.to_h,
        round: @round
      }
    end
  end

  class GameFactory
    def create_pennies_game id, deck, players, room
      PenniesGame.new id, deck, players, room
    end
  end

  class GameMaster
    def initialize game_factory = GameFactory.new, deck_factory = Application::Game::DeckFactory.new
      @games = {}
      @game_factory = game_factory
      @deck_factory = deck_factory
      @uuid_gen = UUID.new
    end

    def start_game room
      if (room.players.count / 2).round <= 2
        number_of_decks = 2
      else
        number_of_decks = (room.players.count / 2).round
      end
      deck = @deck_factory.build_deck
      uuid = @uuid_gen.generate
      @games[uuid] = @game_factory.create_pennies_game uuid, deck, room.players, room
      room.game = @games[uuid]
      @games[uuid].deal
      @games[uuid].to_h
    end
  end

  Application::GAMEMASTER = GameMaster.new
end
