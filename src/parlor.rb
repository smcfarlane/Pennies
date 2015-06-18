
module Application
  class Room
    attr_accessor :players, :name, :game, :id
    def initialize id, name
      @players = {}
      @game = {}
      @name = name
      @id = id
    end

    def to_h
      {
        id: @id,
        name: @name,
        players: @players.values.map {|player| player.to_h}
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
        @rooms[room_id].players[player_id] = @players[player_id]
        @rooms[room_id]
      end
    end

    def remove_player_from_room room_id, player_id
      if @rooms[room_id] && @players[player_id]
        @rooms[room_id].players.delete player_id
        get_all_rooms
      end
    end

    def remove_room room_id
      if @rooms[room_id]
        @rooms.delete room_id
      end
    end
  end

  PARLOR = Parlor.new
end
