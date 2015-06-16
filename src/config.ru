require_relative 'server'

Faye::WebSocket.load_adapter('thin')
use Application::GameServer::GameBackend

run Application::GameServer::Web
