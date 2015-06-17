require_relative 'message_dispatcher'

module Application
  module Handlers
    class MessageHandler
      def register_dispatcher dispatcher
        @dispatcher = self
      end
    end
  end
end
