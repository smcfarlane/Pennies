require_relative 'message_handler'

module Application
  module Handlers
    class AddPlayer < MessageHandler
      def handle(message)
        [:add_player, message['player']]
      end

      def handler_name
        'add_player'
      end
    end

    Application::Dispatcher.register AddPlayer.new
  end
end
