require_relative 'message_handler'
require 'uuid'

module Application
  module Handlers
    class GetPlayerInfo < MessageHandler
      def handle(message)
        [:get_player_info, message['id']]
      end

      def handler_name
        'get_player_info'
      end
    end

    Application::Dispatcher.register GetPlayerInfo.new
  end
end
