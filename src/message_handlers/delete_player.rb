require_relative 'message_handler'
require 'json'
require 'byebug'

module Application
  module Handlers
    class DeletePlayer < MessageHandler
      def handle(message)
        @dispatcher.access_parlor 'delete_player', :remove_player, :deleted_player, message['player']['id']
      end

      def deleted_player result
        player, players = result
        @dispatcher.send_to_all_clients JSON.dump({handler: 'delete_player', player: player, players: players})
      end

      def handler_name
        'delete_player'
      end
    end

    Application::Dispatcher.register DeletePlayer.new
  end
end
