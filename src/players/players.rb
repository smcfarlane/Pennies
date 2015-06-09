require_relative 'player'

class Players
  attr_accessor :list
  def initialize players
    if players[0].is_a? Hash
      @list = []
      players.each_with_index do |p, i|
        @list.push(Player.new(p["name"], p["position"], p["hand"], p["pennies"], p["score"]))
      end
    else
      @list = []
      players.each_with_index do |p, i|
        @list.push(Player.new(p, i, []))
      end
    end
  end

  def to_a
    a = []
    @list.each {|p| a.push(p.to_h)}
    a
  end
end
