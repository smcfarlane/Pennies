require_relative 'message_handler'

module Application
  module Handlers
    class CreateRoom < MessageHandler
      def handle(message)
        @uuid_gen = UUID.new
        @dispatcher.access_parlor :create_room, @uuid_gen.generate, message['room_name']
        message['player']
      end

      def return result

      end

      def handler_name
        'create_room'
      end
    end

    Application::Dispatcher.register CreateRoom.new
  end
end
