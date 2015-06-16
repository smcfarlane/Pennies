require_relative 'message_handler'

module Application
  module Handlers
    class DeletePlayer < MessageHandler
      def handle(message)
        [:delete_player, message['player']]
      end

      def handler_name
        'delete_player'
      end
    end

    Application::Dispatcher.register DeletePlayer.new
  end
end
