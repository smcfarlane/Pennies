
module Application
  class Room
    attr_accessor :players, :name, :game
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
        players: @players.values
      }
    end
  end

  class player
    attr_accessor :player, :ws
    def initialize player, ws
      @player = player
      @ws = ws
    end
  end

  class Parlor
    def initialize
      @rooms = {}
      @players = {}
    end

    def set_player player, ws
      @players[player['id']] = Player.new player, ws
      player
    end

    def get_player player_id
      @player[player_id]
    end

    def remove_player player_id
      if @player['player_id']
        @player.delete player_id
      end
    end

    def set_room id, name
      @room[id] = Room.new id, name
      @room[id]
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
      end
    end

    def remove_room room_id
      if @rooms[room_id]
        @rooms.delete room_id
      end
    end
  end
end
