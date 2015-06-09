require_relative 'game_state'

class Game
  attr_reader :play
  def initialize game_state, play
    @state = game_state
    @play = play
  end

  def validate_play
    @play.validate(@state.game[:round], @state.game[:table])
  end

  def play
    @state.game[:table] = @play.play! @state.game[:table]
  end

  def set_state
    state = {
      current_player: @state.game[:current_player] + 1,
      deck: @state.game[:deck],
      discard_pile: @state.game[:discard_pile],
      winner: false,
      round: @state.game[:round],
      round_rules: Rules::rules(@state.game[:round]),
      table: @state.game[:table]
    }
    gs = GameState.new @state.players, state
    gs.set_json_state
  end
end
