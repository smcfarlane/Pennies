require_relative 'message_handler'
require 'json'

module Application
  module Handlers
    class CreateRoom < MessageHandler
      def handle(message)
        @uuid_gen = UUID.new
        @dispatcher.access_parlor 'create_room', :set_room, :created_room, @uuid_gen.generate, message['room_name']
        @dispatcher.access_parlor 'create_room', :add_player_to_room, :added_player_to_room, @room_id,  message['player']['id']
      end

      def created_room room
        @room_id = room.id
      end

      def added_player_to_room room
        @dispatcher.send_to_all_clients JSON.dump({handler: 'create_room', room: room.to_h})
      end

      def handler_name
        'create_room'
      end
    end

    Application::Dispatcher.register CreateRoom.new
  end
end
