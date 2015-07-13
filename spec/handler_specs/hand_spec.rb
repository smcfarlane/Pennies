require_relative 'spec_helper'
require_relative '../src/players/hand'
require_relative '../src/table/deck'

RSpec.describe "Hand" do
  context 'A hand ' do
    deck = Deck.new [], 2
    h = Hand.new(deck)
    count = h.cards.count
    it 'has cards' do
      expect(h).to respond_to(:cards)
    end

    it 'starts with 11 cards' do
      expect(count).to eq(11)
    end
  end
end
