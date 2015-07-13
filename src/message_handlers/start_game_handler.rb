require_relative 'message_handler'
require 'json'

module Application
  module Handlers
    class StartGame < MessageHandler
      def handle(message)
        @dispatcher.access_parlor 'start_game', :get_room, :room, message['room_id']
      end

      def start_game
        @dispatcher.access_game 'start_game', :start_game, :init_game, @room
      end

      def room room
        @room = room
        if room.game == {}
          start_game
        else
          @dispatcher.send_to_room(JSON.dump({handler: 'error', message: 'room already has a game'}), room)
        end
      end

      def init_game game
        @dispatcher.send_to_room(JSON.dump({handler: 'starting_game', game: game}))
      end

      def handler_name
        'start_game'
      end
    end

    Application::Dispatcher.register StartGame.new
  end
end
