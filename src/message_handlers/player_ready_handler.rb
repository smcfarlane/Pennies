require_relative 'message_handler'
require 'json'

module Application
  module Handlers
    class PlayerReady < MessageHandler
      def handle(message)
        @dispatcher.access_parlor 'player_ready', :player_ready, :reset_rooms, message['room_id'],  message['player']['id']
      end

      def reset_rooms rooms
        rooms = [rooms] if rooms.is_a? Hash
        @dispatcher.send_to_all_clients JSON.dump({handler: 'reset_rooms', rooms: rooms})
      end

      def handler_name
        'player_ready'
      end
    end

    Application::Dispatcher.register PlayerReady.new
  end
end
