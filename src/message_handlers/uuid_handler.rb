require_relative 'message_handler'
require 'uuid'

module Application
  module Handlers
    class GetUUID < MessageHandler
      def initialize
        @uuid_gen = UUID.new
      end

      def handle(message)
        [:get_uuid, @uuid_gen.generate]
      end

      def handler_name
        'get_uuid'
      end
    end

    Application::Dispatcher.register GetUUID.new
  end
end
