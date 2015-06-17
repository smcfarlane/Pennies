require_relative 'message_handler'

module Application
  module Handlers
    class AddPlayer < MessageHandler
      def handle(message)
        @dispatcher.access_parlor 'add_player', :set_player, :add_player, player, @current_ws
      end

      def add_player player
        @dispatcher.send_to_all_clients(JSON.dump({handler: 'add_player', player: player['name']}))
      end

      def handler_name
        'add_player'
      end
    end

    Application::Dispatcher.register AddPlayer.new
  end
end
