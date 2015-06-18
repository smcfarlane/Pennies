require_relative 'message_handler'
require 'json'

module Application
  module Handlers
    class StartGame < MessageHandler
      def handle(message)
        @dispatcher.access_parlor 'start_game', :get_room, :room, message['room_id']
        @dispatcher.access_game 'start_game', :start_game, :init_game, @room
      end

      def room room
        @room = room
      end

      def init_room game
        
      end

      def handler_name
        'start_game'
      end
    end

    Application::Dispatcher.register StartGame.new
  end
end
