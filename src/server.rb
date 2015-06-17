require 'faye/websocket'
require 'sinatra'
require 'json'
require_relative 'app'
require 'require_all'
require_all 'message_handlers'

module Application
  module GameServer
    class Web < Sinatra::Base
      dir = File.dirname(__FILE__).split(%r{/})
      dir = dir.join('/')
      set :public_folder, dir + '/public/'
      get '/' do
        erb :"index.html"
      end
    end

    class GameBackend
      KEEPALIVE_TIME = 30 # in seconds

      def initialize(app)
        @rack_app     = app
        @app = Application::APP
      end

      def call(env)
        if Faye::WebSocket.websocket?(env)
          # WebSockets logic goes here
          ws = Faye::WebSocket.new(env, nil, ping: KEEPALIVE_TIME)

          ws.on :open do |_event|
            p [:open, ws.object_id]
            @app.clients << ws
            # inital data
            ws.send(JSON.dump({handler: 'initial_data', rooms: @app.rooms.map {|r| r.to_h}, players: @app.players}))
          end

          ws.on :message do |event|
            message = JSON.parse(event.data)
            p [:message, message]
            @app.ws = ws
            Application::Dispatcher.handle_message message
          end

          ws.on :close do |event|
            p [:close, ws.object_id, event.code, event.reason]
            @app.clients.delete(ws)
            @app.client_players.each do |k, v|
              if v == ws
                @app.delete_player @app.players[k]
                @app.players.delete k
                @app.client_players.delete k
              end
            end
            ws = nil
            p @app.players
          end
          # Return async Rack response
          ws.rack_response
        else
          @rack_app.call(env)
        end
      end
    end
  end
end
