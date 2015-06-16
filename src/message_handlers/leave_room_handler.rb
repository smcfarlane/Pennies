require_relative 'message_handler'

module Application
  module Handlers
    class LeaveRoom < MessageHandler
      def handle(message)
        [:leave_room, [message['room_id'], message['player']]]
      end

      def handler_name
        'leave_room'
      end
    end

    Application::Dispatcher.register LeaveRoom.new
  end
end
