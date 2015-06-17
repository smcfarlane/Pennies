require 'json'

module Application
  class Room
    attr_accessor :players, :name, :game
    def initialize id, name
      @players = []
      @game = {}
      @name = name
      @id = id
    end

    def to_h
      {
        id: @id,
        name: @name,
        players: @players
      }
    end
  end

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

    def get_uuid uuid
      @ws.send(JSON.dump({handler: 'get_uuid', id: uuid}))
    end

    def join_room room_id_player
      @rooms[room_id_player[0].to_i].players << room_id_player[1]
      json = JSON.dump({handler: 'reset_rooms', rooms: @rooms.map {|r| r.to_h}})
      @clients.each {|client| client.send(json)}
    end

    def leave_room room_id_player
      index = @rooms[room_id_player[0].to_i].players.index{|p| p["id"] == room_id_player[1]["id"]}
      @rooms[room_id_player[0].to_i].players.delete_at index
      @rooms.delete_at room_id_player[0].to_i if @rooms[room_id_player[0].to_i].players.empty?
      json = JSON.dump({handler: 'reset_rooms', rooms: @rooms.map {|r| r.to_h}})
      @clients.each {|client| client.send(json)}
    end

    def add_player player
      @client_players[player["id"]] = @ws
      @players[player["id"]] = player
      json = JSON.dump({handler: 'add_player', player: player["name"]})
      @clients.each {|client| client.send(json)}
      p @players
    end

    def get_player_info id
      @ws.send(JSON.dump({handler: 'get_player_info', player: @players['id']})) if @players['id']
    end

    def create_room name_player
      room = Room.new(@rooms.count, name_player[0])
      room.players << name_player[1]
      @rooms << room
      json = JSON.dump({handler: 'create_room', player: name_player[1], room: room.to_h})
      @clients.each {|client| client.send(json)}
    end

    def delete_player player
      if player
        if player["id"]
          @players.delete(player['id'])
          json = JSON.dump({handler: 'delete_player', player: player, players: @players})
          @clients.each {|client| client.send(json)}
        end
      end
    end
  end

  APP = App.new
end
