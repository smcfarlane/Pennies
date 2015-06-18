require_relative 'message_handler'
require 'json'

module Application
  module Handlers
    class JoinRoom < MessageHandler
      def handle(message)
        @dispatcher.access_parlor 'join_room', :add_player_to_room, :added_player_to_room, message['room_id'],  message['player']['id']
      end

      def added_player_to_room rooms
        @dispatcher.access_parlor 'join_room', :get_all_rooms, :reset_rooms
      end

      def reset_rooms rooms
        @dispatcher.send_to_all_clients JSON.dump({handler: 'reset_rooms', rooms: rooms})
      end

      def handler_name
        'join_room'
      end
    end

    Application::Dispatcher.register JoinRoom.new
  end
end
