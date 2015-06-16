require_relative '../server'
require 'byebug'
module Application
  class MessageDispatcherKlass
    def initialize(app)
      @handlers = {}
      @app = app
    end

    def register(handler)
      @handlers[handler.handler_name] = handler
    end

    def handle_message(message)
      action = @handlers[message['handler']].handle message
      @app.send action[0], action[1]
    end
  end

  Dispatcher = MessageDispatcherKlass.new Application::APP
end
