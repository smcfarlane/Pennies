
module Application
  class Room
    attr_accessor :players, :name, :game, :id, :status
    def initialize id, name
      @players = {}
      @game = {}
      @name = name
      @id = id
      @status = "waiting"
      @players_ready = []
    end

    def to_h
      {
        id: @id,
        name: @name,
        players: @players.values.map {|player| player.to_h},
        status: @status,
        players_ready: []
      }
    end
  end

  class Player
    attr_accessor :player, :ws
    def initialize player, ws
      @player = player
      @ws = ws
    end

    def to_h
      @player
    end
  end

  class Parlor
    def initialize
      @rooms = {}
      @players = {}
      @player_room = {}
    end

    def get_all_players
      @players.map {|key, player| player.to_h}
    end

    def get_all_rooms
      @rooms.map {|key, room| room.to_h}
    end

    def set_player player, ws
      @players[player['id']] = Player.new player, ws
      player.to_h
    end

    def get_player player_id
      @players[player_id].to_h if @players.keys.include? player_id
    end

    def remove_player player_id
      if @players.keys.include? player_id
        player = @players[player_id]
        @players.delete player_id
        [player.to_h, get_all_players]
      end
    end

    def set_room id, name
      @rooms[id] = Room.new id, name
      @rooms[id]
    end

    def add_player_to_room room_id, player_id
      if @rooms[room_id] && @players[player_id]
        if @player_room.keys.include? player_id
          remove_player_from_room @player_room[player_id], player_id
          @player_room.delete player_id
        end
        @rooms[room_id].players[player_id] = @players[player_id]
        @player_room[player_id] = room_id
        @rooms[room_id]
      end
    end

    def remove_player_from_room room_id, player_id
      if @rooms[room_id] && @players[player_id]
        @rooms[room_id].players.delete player_id
        @player_room.delete player_id
        if @rooms[room_id].players == {}
          remove_room room_id
        end
        get_all_rooms
      end
    end

    def remove_room room_id
      if @rooms[room_id]
        @rooms[room_id].players.keys.each {|id| @player_room.delete id}
        @rooms.delete room_id
      end
    end

    def player_ready room_id, player_id
      if @rooms[room_id] && @players[player_id]
        @rooms[room_id].players_ready << player_id
        @rooms[room_id].to_h
      end
    end
  end

  PARLOR = Parlor.new
end
