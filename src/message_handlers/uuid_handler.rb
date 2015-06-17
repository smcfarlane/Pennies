require_relative 'message_handler'
require 'uuid'

module Application
  module Handlers
    class GetUUID < MessageHandler
      def initialize
        @uuid_gen = UUID.new
      end

      def handle(message)
        @dispatcher.send_to_current_client JSON.dump({handler: 'get_uuid', uuid: @uuid_gen.generate})
      end

      def handler_name
        'get_uuid'
      end
    end

    Application::Dispatcher.register GetUUID.new
  end
end
