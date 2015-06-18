require_relative 'message_handler'
require 'json'

module Application
  module Handlers
    class GetPlayer < MessageHandler
      def handle(message)
        @dispatcher.access_parlor :get_player, :got_player, message['id']
      end

      def got_player player
        @dispatcher.send_to_current_client JSON.dump({handler: 'get_player', player: player})
      end

      def handler_name
        'get_player'
      end
    end

    Application::Dispatcher.register GetPlayer.new
  end
end
