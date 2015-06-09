

class Deck
  attr_reader :cards

  def initialize deck_array = [], num_of_decks = 2
    @num = num_of_decks
    deck_array != [] ? @cards = deck_array : @cards = get_new_decks
  end

  def get_new_decks
    (get_single_deck * @num).shuffle
  end

  def get_single_deck
    hearts = %w(1h 2h 3h 4h 5h 6h 7h 8h 9h 10h 11h 12h 13h)
    spades = %w(1s 2s 3s 4s 5s 6s 7s 8s 9s 10s 11s 12s 13s)
    dimonds = %w(1d 2d 3d 4d 5d 6d 7d 8d 9d 10d 11d 12d 13d)
    clubs = %w(1c 2c 3c 4c 5c 6c 7c 8c 9c 10c 11c 12c 13c)
    jokers = %w(1j 2j)
    [hearts, spades, dimonds, clubs, jokers].flatten
  end

  def draw_cards num = 11
    @cards.shift num
  end
end
