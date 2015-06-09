

class Player
  attr_accessor :name, :position, :hand, :score
  def initialize(name, position, hand, pennies = 10, score = 0)
    @name = name
    @position = position
    @hand = hand
    @score = score
    @pennies = pennies
  end

  def to_h
    {
      name: @name,
      postion: @postion,
      hand: @hand.cards,
      score: @score
    }
  end
end
