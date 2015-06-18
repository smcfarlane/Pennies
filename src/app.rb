require 'json'

module Application
  class App
    attr_reader :rooms, :clients, :players, :client_players
    attr_accessor :ws
    def initialize
      @ws = ''
      @rooms = []
      @clients = []
      @players = {}
      @client_players = {}
    end
  end

  APP = App.new
end
