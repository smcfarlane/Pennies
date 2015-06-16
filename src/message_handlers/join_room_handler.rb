require_relative 'message_handler'

module Application
  module Handlers
    class JoinRoom < MessageHandler
      def handle(message)
        [:join_room, [message['room_id'], message['player']]]
      end

      def handler_name
        'join_room'
      end
    end

    Application::Dispatcher.register JoinRoom.new
  end
end
