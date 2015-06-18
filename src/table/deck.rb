require_relative '../rules'

module Application
  module Game
    class Deck
      attr_reader :cards

      def initialize num_of_decks = 2
        @num_of_decks = num_of_decks
        @cards = get_new_decks
      end

      def get_new_decks
        (get_single_deck * @num_of_decks).shuffle
      end

      def get_single_deck
        [
          Application::Game::Rules::HEARTS,
          Application::Game::Rules::SPADES,
          Application::Game::Rules::DIAMONDS,
          Application::Game::Rules::CLUBS,
          Application::Game::Rules::JOKERS
        ].flatten
      end

      def draw_cards num = 11
        @cards.shift num
      end
    end

    class DeckFactory
      def build_deck number_of_decks
        Deck.new number_of_decks
      end
    end
  end
end
