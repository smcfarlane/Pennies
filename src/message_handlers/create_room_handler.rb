require_relative 'message_handler'

module Application
  module Handlers
    class CreateRoom < MessageHandler
      def handle(message)
        [:create_room, [message['room_name'], message['player']]]
      end

      def handler_name
        'create_room'
      end
    end

    Application::Dispatcher.register CreateRoom.new
  end
end
