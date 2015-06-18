require_relative 'message_handler'
require 'json'

module Application
  module Handlers
    class LeaveRoom < MessageHandler
      def handle(message)
        @dispatcher.access_parlor 'leave_room', :remove_player_from_room, :removed_player_from_room, message['room_id'],  message['player']['id']
      end

      def removed_player_from_room rooms
        @dispatcher.send_to_all_clients JSON.dump({handler: 'reset_rooms', rooms: rooms})
      end

      def handler_name
        'leave_room'
      end
    end

    Application::Dispatcher.register LeaveRoom.new
  end
end
