
module Application
  class MessageDispatcherKlass
    attr_reader :app
    def initialize app, parlor, game_master
      @handlers = {}
      @app = app
      @parlor = parlor
      @gm = game_master
    end

    def register(handler)
      @handlers[handler.handler_name] = handler
      @handlers[handler.handler_name].register_dispatcher self
    end

    def handle_message(message)
      @handlers[message['handler']].handle message
    end

    def access_parlor handler, method, handler_method, *args
      result = @parlor.send(method, *args)
      @handlers[handler].send handler_method, result
    end

    def access_game handler, method, handler_method, *args
      result = @gm.send(method, *args)
      @handlers[handler].send handler_method, result
    end

    def send_to_current_client message
      @app.ws.send(message)
    end

    def send_to_room message, room
      room.players.each {|client| client.ws.send(message)}
    end

    def send_to_all_clients message
      @app.clients.each {|client| client.send(message)}
    end
  end

  Dispatcher = MessageDispatcherKlass.new Application::APP, Application::PARLOR, Application::GAMEMASTER
end
