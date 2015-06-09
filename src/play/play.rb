require_relative '../rules'
require_relative 'validators'
require_relative '../table/table'

class Play
  attr_reader :player, :position, :cards_played, :discard, :hand_state, :down, :round
  def initialize play, round, validator = PlayValidator.new
    @validator = validator
    @player = play["player"]
    @position = play["position"]
    @down = play["down"]
    @cards_played = play["cards_played"]
    @discard = play["discard"]
    @hand_state = play["hand_state"]
    @round = round
    @rule = Rules::ROUNDS[@round - 1]
  end

  def if_down
    yield if @down
  end

  def if_not_down
    yield unless @down
  end

  def validate round, table
    @validator.validate(round, self, table)
  end

  def valid?
    @validator.results == []
  end

  def play! table
    alter_table table
  end

  private

  def alter_table table
    t = Table.new table
    @cards_played['sets'].each {|set| t.play_set set}
    @cards_played['other'].each {|card| t.play_other card}
    t.table
  end
end
