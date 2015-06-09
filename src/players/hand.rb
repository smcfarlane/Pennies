require_relative '../table/deck'

class Hand
  attr_reader :cards
  def initialize deck = Deck.new, hand = []
    hand != [] ? @cards = hand : @cards = deck.draw_cards(11)
    @deck = deck

  end

  def card_in_hand? card
    @cards.index(card) == nil
  end

  def remove_card card
    @cards.slice!(a.index(card), 1)
  end
end
