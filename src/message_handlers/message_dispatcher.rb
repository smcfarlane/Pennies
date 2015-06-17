require_relative '../server'
require 'byebug'
module Application
  class MessageDispatcherKlass
    def initialize(app, parlor)
      @handlers = {}
      @app = app
      @parlor = parlor
      @current_ws = @app.ws
    end

    def register(handler)
      @handlers[handler.handler_name] = handler
    end

    def handle_message(message)
      action = @handlers[message['handler']].handle message
      @app.send action[0], action[1]
    end

    def access_parlor handler, method, *args
      result = @parlor.send(method, *args)
      @handlers[handler].return result
    end

    def send_to_all_clients message
      @app.clients.each {|client| client.send(json)}
    end
  end

  Dispatcher = MessageDispatcherKlass.new Application::APP
end
