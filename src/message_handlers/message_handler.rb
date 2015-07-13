
module Application
  module Handlers
    class MessageHandler
      def register_dispatcher dispatcher
        @dispatcher = dispatcher
      end
    end
  end
end
